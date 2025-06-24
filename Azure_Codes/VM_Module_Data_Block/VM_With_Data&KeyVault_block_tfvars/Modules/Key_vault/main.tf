resource "azurerm_key_vault" "kv" {
  name                       = var.kv_name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.tnt.tenant_id
  sku_name                   = "standard"
  soft_delete_retention_days = 7

  access_policy {
    tenant_id = data.azurerm_client_config.tnt.tenant_id
    object_id = data.azurerm_client_config.tnt.object_id

   
    secret_permissions = [
      "Set",
      "Get",
      "Delete",
      "Purge",
      "Recover",
      "List",
      "Backup",
      "Restore",
      "Create",
    ]
  }
}

