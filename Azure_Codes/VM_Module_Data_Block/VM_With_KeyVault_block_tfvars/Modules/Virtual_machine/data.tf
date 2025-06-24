data "azurerm_network_interface" "nic" {
  name                = var.nic_name
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault" "kv" {
  name                = var.key_vault
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "username" {
  name         = var.username
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "password" {
  name         = var.password
  key_vault_id = data.azurerm_key_vault.kv.id
}
