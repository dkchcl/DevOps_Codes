resource_group_name     = "dkc-vm-rg"
location                = "West Europe"
vnet_name               = "vnet-vm-01"
vnet_address_space      = "10.0.0.0/16"
subnet_name             = "subnet-vm"
subnet_address_prefix   = "10.0.2.0/24"
nsg_name                = "vm-nsg"
public_ip_name          = "vm-public-ip"
nic_name                = "vm-nic1"
vm_name                 = "linuxvm"
vm_size                 = "Standard_F2"
admin_username          = "adminuser"
admin_password          = "P@ssw0rd1234!"  # ⚠️ Change in production

# Ubuntu 22.04 LTS Image
image_publisher = "Canonical"
image_offer     = "0001-com-ubuntu-server-jammy"
image_sku       = "22_04-lts"
