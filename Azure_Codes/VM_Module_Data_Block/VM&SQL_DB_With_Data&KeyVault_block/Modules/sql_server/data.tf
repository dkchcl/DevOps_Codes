data "azurerm_key_vault" "kv" {
  name                = var.key_vault
  resource_group_name = var.resource_group_name
}

data "azurerm_key_vault_secret" "username1" {
  name         = var.username
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "password1" {
  name         = var.password
  key_vault_id = data.azurerm_key_vault.kv.id
}