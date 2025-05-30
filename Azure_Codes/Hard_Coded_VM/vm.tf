resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "linuxvm"
  resource_group_name             = "dkc-rg-vm"
  location                        = "West Europe"
  size                            = "Standard_F2"
  admin_username                  = "adminuser"
  disable_password_authentication = false
  admin_password                  = "P@ssw0rd1234!"  # ⚠️ Strong password rakho

  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  depends_on = [
    azurerm_network_interface.nic
  ]
}
