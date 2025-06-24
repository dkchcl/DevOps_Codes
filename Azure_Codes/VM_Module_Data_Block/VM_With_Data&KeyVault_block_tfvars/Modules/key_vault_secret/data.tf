data "azurerm_key_vault" "kv1" {
  name                = var.kv_name
  resource_group_name = var.resource_group_name
}