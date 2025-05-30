resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name
  
  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id             = var.subnet_id
    public_ip_address_id  = var.public_ip_id
  }
}