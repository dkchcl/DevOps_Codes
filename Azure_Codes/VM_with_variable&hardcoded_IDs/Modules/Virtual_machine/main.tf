
resource "azurerm_network_interface" "f_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.ip_config
    subnet_id                     = "/subscriptions/92e22e38-2f32-450c-97de-3c896645b2da/resourceGroups/dkc-rg-02/providers/Microsoft.Network/virtualNetworks/todovnet/subnets/subnet1"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "/subscriptions/92e22e38-2f32-450c-97de-3c896645b2da/resourceGroups/dkc-rg-02/providers/Microsoft.Network/publicIPAddresses/frontend_pip"
  }
}

resource "azurerm_virtual_machine" "vm" {
  depends_on = [ azurerm_network_interface.f_nic ]
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = ["/subscriptions/92e22e38-2f32-450c-97de-3c896645b2da/resourceGroups/dkc-rg-02/providers/Microsoft.Network/networkInterfaces/nic1"]
  vm_size               = var.vm_size

  storage_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
  storage_os_disk {
    name              = var.os_disk_name
    caching           = var.caching
    create_option     = var.create_option
    managed_disk_type = var.managed_disk_type
  }
  os_profile {
    computer_name  = var.computer_name
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
}