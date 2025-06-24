resource_group_name  = "dkc-rg-01"
location             = "central india"
virtual_network_name = "todovnet"
address_space        = ["10.0.0.0/16"]
frontend_subnet      = "subnet1"
address_prefixes_f   = ["10.0.1.0/24"]
backend_subnet       = "subnet2"
address_prefixes_b   = ["10.0.2.0/24"]
nsg_name             = "todonsg"
f_public_ip          = "frontend_pip"
b_public_ip          = "backend_pip"
f_nic_name           = "nic1"
b_nic_name           = "nic2"
ip_config            = "testconfig"
f_vm_name            = "frontendvm"
b_vm_name            = "backendvm"
vm_size              = "Standard_D2_v3"
publisher            = "Canonical"
offer                = "0001-com-ubuntu-server-jammy"
sku                  = "22_04-lts"
caching              = "ReadWrite"
storage_account_type = "Standard_LRS"
kv_name              = "vmkikeyvault4"
username             = "username"
password             = "password"
vmusername           = "vmusername"
vmpassword           = "Bbpl@#2304"



