#############################################
# main.tf - Secure Azure Storage Account with Private Endpoint
#############################################

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "= 4.28.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = ">= 3.5.1"
    # }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "177b7e12-5f03-4f63-bcd1-ed6d1d776bff"
}

variable "location" {
  type    = string
  default = "eastus"
}

# variable "tags" {
#   type = map(string)
#   default = {
#     environment = "prod"
#     owner       = "platform-sec"
#     managed-by  = "terraform"
#   }
# }

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-secure-sa"
  location = var.location
}

# Random storage account name
resource "random_string" "sa" {
  length  = 12
  lower   = true
  upper   = false
  numeric = true
  special = false
}

# Secure Storage Account
resource "azurerm_storage_account" "sa" {
  name                              = "st${random_string.sa.result}"
  resource_group_name               = azurerm_resource_group.rg.name
  location                          = azurerm_resource_group.rg.location
  account_tier                      = "Standard"
  account_replication_type          = "GRS"
  account_kind                      = "StorageV2"
  min_tls_version                   = "TLS1_2"
  https_traffic_only_enabled        = true
  # allow_blob_public_access          = false
  infrastructure_encryption_enabled = true
  cross_tenant_replication_enabled  = false
  shared_access_key_enabled         = false
  public_network_access_enabled     = false
  allow_nested_items_to_be_public = false

  queue_properties {
    logging {
      delete                = true
      read                  = true
      write                 = true
      version               = "1.0"
      retention_policy_days = 10
    }
  }
  
  identity {
    type = "SystemAssigned"
  }

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  blob_properties {
    versioning_enabled = true
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }

}

data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "kv" {
  name                = "dkckv"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"
  soft_delete_retention_days  = 7
  purge_protection_enabled = true

  public_network_access_enabled = false

  network_acls {
    ip_rules = ["10.0.1.0/28"]
    default_action = "Deny"
    bypass = "AzureServices"
  }
}

resource "azurerm_key_vault_access_policy" "client" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions    = ["Get", "Create", "Delete", "List", "Restore", "Recover", "UnwrapKey", "WrapKey", "Purge", "Encrypt", "Decrypt", "Sign", "Verify"]
  secret_permissions = ["Get"]
}

resource "azurerm_key_vault_key" "kvk" {
  name         = "tfex-key"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA-HSM"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]
  expiration_date = "2020-12-30T20:00:00Z"

  depends_on = [
    azurerm_key_vault_access_policy.client
  ]
}


resource "azurerm_storage_account_customer_managed_key" "cmk" {
  storage_account_id = azurerm_storage_account.sa.id
  key_vault_id       = azurerm_key_vault.kv.id
  key_name           = azurerm_key_vault_key.kvk.name
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-sa"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Subnet for Private Endpoint
resource "azurerm_subnet" "subnet" {
  name                                          = "snet-sa-private"
  resource_group_name                           = azurerm_resource_group.rg.name
  virtual_network_name                          = azurerm_virtual_network.vnet.name
  address_prefixes                              = ["10.0.1.0/24"]
  # private_endpoint_network_policies_enabled     = false
}

resource "azurerm_network_security_group" "nsg" {
  name                = "sa-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "assoc" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

# Private Endpoint for Blob
resource "azurerm_private_endpoint" "pe" {
  name                = "pe-sa-blob"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "sa-blob-connection"
    private_connection_resource_id = azurerm_storage_account.sa.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sa-blob-dns-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.dns.id]
  }

}

# Private DNS Zone
resource "azurerm_private_dns_zone" "dns" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = azurerm_resource_group.rg.name
}

# Link VNet to Private DNS
resource "azurerm_private_dns_zone_virtual_network_link" "dnslink" {
  name                  = "link-vnet"
  resource_group_name   = azurerm_resource_group.rg.name
  private_dns_zone_name = azurerm_private_dns_zone.dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  registration_enabled  = false
}

resource "azurerm_private_endpoint" "kv-pe" {
  name                = "sa-private-endpoint"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  subnet_id           = azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "sa-private-connection"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_key_vault.kv.id
    subresource_names              = ["vault"]
  }
}

# Outputs
output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}

output "private_endpoint_id" {
  value = azurerm_private_endpoint.pe.id
}

