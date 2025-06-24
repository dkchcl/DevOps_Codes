module "rg" {
  source              = "../Modules/resource_group"
  resource_group_name = "dkc-rg-01"
  location            = "central india"
}

module "virtual_network" {
  depends_on           = [module.rg]
  source               = "../Modules/virtual_network"
  resource_group_name  = "dkc-rg-01"
  location             = "central india"
  virtual_network_name = "todovnet"
  address_space        = ["10.0.0.0/16"]
}

module "f_subnet" {
  depends_on           = [module.rg, module.virtual_network]
  source               = "../Modules/subnet"
  resource_group_name  = "dkc-rg-01"
  virtual_network_name = "todovnet"
  subnet               = "subnet1"
  address_prefixes     = ["10.0.1.0/24"]
}

module "b_subnet" {
  depends_on           = [module.rg, module.virtual_network]
  source               = "../Modules/subnet"
  resource_group_name  = "dkc-rg-01"
  virtual_network_name = "todovnet"
  subnet               = "subnet2"
  address_prefixes     = ["10.0.2.0/24"]
}

module "nsg" {
  depends_on          = [module.rg]
  source              = "../Modules/network_security_group"
  nsg_name            = "todonsg"
  resource_group_name = "dkc-rg-01"
  location            = "central india"
}

module "f_pip" {
  depends_on          = [module.rg]
  source              = "../Modules/Public_ip"
  public_ip           = "frontend_pip"
  resource_group_name = "dkc-rg-01"
  location            = "central india"
}

module "b_pip" {
  depends_on          = [module.rg]
  source              = "../Modules/Public_ip"
  public_ip           = "backend_pip"
  resource_group_name = "dkc-rg-01"
  location            = "central india"
}

module "nsg_assoc" {
  depends_on = [ module.rg , module.virtual_network , module.f_subnet , module.nsg ]
  source               = "../Modules/nsg_assoc"
  resource_group_name  = "dkc-rg-01"
  virtual_network_name = "todovnet"
  subnet               = "subnet1"
  nsg_name             = "todonsg"
}

module "nsg_assoc1" {
  depends_on = [ module.rg , module.virtual_network , module.b_subnet , module.nsg ]
  source               = "../Modules/nsg_assoc"
  resource_group_name  = "dkc-rg-01"
  virtual_network_name = "todovnet"
  subnet               = "subnet2"
  nsg_name             = "todonsg"
}

module "nic1" {
  depends_on = [ module.f_subnet , module.f_pip ]
  source = "../Modules/nic"
  nic_name = "nic1"
  resource_group_name = "dkc-rg-01"
  location = "central india"
  virtual_network_name = "todovnet"
  ip_config = "testconfig"
  subnet = "subnet1"
  public_ip = "frontend_pip"
}

module "nic2" {
  depends_on = [ module.b_subnet , module.b_pip ]
  source = "../Modules/nic"
  nic_name = "nic2"
  resource_group_name = "dkc-rg-01"
  location = "central india"
  virtual_network_name = "todovnet"
  ip_config = "testconfig"
  subnet = "subnet2"
  public_ip = "backend_pip"
}

module "vm" {
  depends_on           = [module.rg , module.nic1]
  source               = "../Modules/Virtual_machine"
  resource_group_name  = "dkc-rg-01"
  location             = "central india"
  nic_name             = "nic1"
  vm_name              = "frontendvm"
  vm_size              = "Standard_D2_v3"
  publisher            = "Canonical"
  offer                = "0001-com-ubuntu-server-jammy"
  sku                  = "22_04-lts"
  os_disk_name         = "myosdisk1"
  caching              = "ReadWrite"
  create_option        = "FromImage"
  managed_disk_type    = "Standard_LRS"
  computer_name        = "todovm1"
  admin_username       = "adminuser"
  admin_password       = "Password1234!"
}

module "vm1" {
  depends_on           = [module.rg , module.nic2]
  source               = "../Modules/Virtual_machine"
  resource_group_name  = "dkc-rg-01"
  location             = "central india"
  nic_name             = "nic2"
  vm_name              = "backendvm"
  vm_size              = "Standard_D2_v3"
  publisher            = "Canonical"
  offer                = "0001-com-ubuntu-server-jammy"
  sku                  = "22_04-lts"
  os_disk_name         = "myosdisk2"
  caching              = "ReadWrite"
  create_option        = "FromImage"
  managed_disk_type    = "Standard_LRS"
  computer_name        = "todovm2"
  admin_username       = "adminuser"
  admin_password       = "Password1234!"
}

