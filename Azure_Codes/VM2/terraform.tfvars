resource_group_name     = "dkc-todo-rg"
location                = "east us"
vnet_name               = "vnet-vm-02"
vnet_address_space      = "10.0.0.0/16"
subnet_name             = "subnet-vm1"
subnet_address_prefix   = "10.0.1.0/24"
nsg_name                = "vm-nsg"
public_ip_name          = "vm-public-ip1"
nic_name                = "vm-nic1"
vm_name                 = "linuxvm"
vm_size                 = "Standard_F2"
admin_username          = "adminuser"
admin_password          = "P@ssw0rd1234!"  # ⚠️ Change in production

# Ubuntu 20.04 LTS Image
image_publisher = "Canonical"
image_offer     = "0001-com-ubuntu-server-focal"
image_sku       = "20_04-lts"
