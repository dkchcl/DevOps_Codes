resource "azurerm_key_vault_secret" "kvs1" {
  name         = var.username
  value        = var.vmusername
  key_vault_id = data.azurerm_key_vault.kv1.id
}

resource "azurerm_key_vault_secret" "kvs2" {
  name         = var.password
  value        = var.vmpassword
  key_vault_id = data.azurerm_key_vault.kv1.id
}