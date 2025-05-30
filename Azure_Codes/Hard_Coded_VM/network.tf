resource "azurerm_virtual_network" "vnet-vm" {
  name                = "vnet-vm-01"
  address_space       = ["10.0.0.0/16"]
  location            = "West Europe"
  resource_group_name = "dkc-rg-vm"

  depends_on = [
    azurerm_resource_group.rg-vm
  ]
}

resource "azurerm_subnet" "subnet" {
  name                 = "subnet-vm"
  resource_group_name  = "dkc-rg-vm"
  virtual_network_name = "vnet-vm-01"
  address_prefixes     = ["10.0.2.0/24"]

  depends_on = [
    azurerm_virtual_network.vnet-vm
  ]
}

resource "azurerm_public_ip" "public-ip" {
  name                = "vm-public-ip"
  location            = "West Europe"
  resource_group_name = "dkc-rg-vm"
  allocation_method   = "Dynamic"
  sku                 = "Basic"

  depends_on = [
    azurerm_resource_group.rg-vm
  ]
}

resource "azurerm_network_interface" "nic" {
  name                = "vm-nic1"
  location            = "West Europe"
  resource_group_name = "dkc-rg-vm"

  ip_configuration {
    name                          = "internal1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-ip.id
  }

  depends_on = [
    azurerm_subnet.subnet,
    azurerm_public_ip.public-ip,
    azurerm_resource_group.rg-vm
  ]
}
