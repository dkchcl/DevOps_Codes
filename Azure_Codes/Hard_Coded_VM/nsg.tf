resource "azurerm_network_security_group" "nsg" {
  name                = "vm-nsg"
  location            = "West Europe"
  resource_group_name = "dkc-rg-vm"

  depends_on = [
    azurerm_resource_group.rg-vm
  ]
}

resource "azurerm_network_security_rule" "ssh" {
  name                        = "allow-ssh"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "dkc-rg-vm"
  network_security_group_name = azurerm_network_security_group.nsg.name

  depends_on = [
    azurerm_network_security_group.nsg
  ]
}

resource "azurerm_subnet_network_security_group_association" "subnet-nsg" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id

  depends_on = [
    azurerm_subnet.subnet,
    azurerm_network_security_group.nsg
  ]
}
