module "rg" {
  source              = "../Modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  depends_on           = [module.rg]
  source               = "../Modules/virtual_network"
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  address_space        = var.address_space
}

module "f_subnet" {
  depends_on           = [module.rg, module.virtual_network]
  source               = "../Modules/subnet"
  frontend_subnet      = var.frontend_subnet
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = var.address_prefixes
}

module "nsg" {
  depends_on          = [module.rg]
  source              = "../Modules/network_security_group"
  nsg_name            = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "pip" {
  depends_on          = [module.rg]
  source              = "../Modules/Public_ip"
  public_ip           = var.public_ip
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "subnet_assoc" {
  depends_on = [ module.f_subnet, module.nsg, module.pip ]
  source = "../Modules/subnet_nsg_assoc"  
}

module "vm" {
  depends_on          = [module.rg , module.f_subnet , module.pip , module.nsg, module.subnet_assoc]
  source              = "../Modules/Virtual_machine"
  resource_group_name = var.resource_group_name
  location            = var.location
  nic_name            = var.nic_name
  ip_config           = var.ip_config
  vm_name             = var.vm_name
  vm_size             = var.vm_size
  publisher           = var.publisher
  offer               = var.offer
  sku                 = var.sku
  os_disk_name        = var.os_disk_name
  caching             = var.caching
  create_option       = var.create_option
  managed_disk_type   = var.managed_disk_type
  computer_name       = var.computer_name
  admin_username      = var.admin_username
  admin_password      = var.admin_password
}