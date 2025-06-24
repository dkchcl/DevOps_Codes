resource "azurerm_key_vault_secret" "kvs" {
  name         = var.username
  value        = var.adminusername
  key_vault_id = data.azurerm_key_vault.kv1.id
}

resource "azurerm_key_vault_secret" "kvs1" {
  name         = var.password
  value        = var.adminpassword
  key_vault_id = data.azurerm_key_vault.kv1.id
}