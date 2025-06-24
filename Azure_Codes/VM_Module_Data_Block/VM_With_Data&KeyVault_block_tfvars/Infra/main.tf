module "rg" {
  source              = "../Modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "virtual_network" {
  depends_on           = [module.rg]
  source               = "../Modules/virtual_network"
  resource_group_name  = var.resource_group_name
  location             = var.location
  virtual_network_name = var.virtual_network_name
  address_space        = var.address_space
}

module "f_subnet" {
  depends_on           = [module.rg, module.virtual_network]
  source               = "../Modules/subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet               = var.frontend_subnet
  address_prefixes     = var.address_prefixes_f
}

module "b_subnet" {
  depends_on           = [module.rg, module.virtual_network]
  source               = "../Modules/subnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet               = var.backend_subnet
  address_prefixes     = var.address_prefixes_b
}

module "nsg" {
  depends_on          = [module.rg]
  source              = "../Modules/network_security_group"
  nsg_name            = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "f_pip" {
  depends_on          = [module.rg]
  source              = "../Modules/Public_ip"
  public_ip           = var.f_public_ip
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "b_pip" {
  depends_on          = [module.rg]
  source              = "../Modules/Public_ip"
  public_ip           = var.b_public_ip
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "nsg_assoc" {
  depends_on           = [module.rg, module.virtual_network, module.f_subnet, module.nsg]
  source               = "../Modules/nsg_assoc"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet               = var.frontend_subnet
  nsg_name             = var.nsg_name
}

module "nsg_assoc1" {
  depends_on           = [module.rg, module.virtual_network, module.b_subnet, module.nsg]
  source               = "../Modules/nsg_assoc"
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  subnet               = var.backend_subnet
  nsg_name             = var.nsg_name
}

module "nic1" {
  depends_on           = [module.f_subnet, module.f_pip]
  source               = "../Modules/nic"
  nic_name             = var.f_nic_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  virtual_network_name = var.virtual_network_name
  ip_config            = var.ip_config
  subnet               = var.frontend_subnet
  public_ip            = var.f_public_ip
}

module "nic2" {
  depends_on           = [module.b_subnet, module.b_pip]
  source               = "../Modules/nic"
  nic_name             = var.b_nic_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  virtual_network_name = var.virtual_network_name
  ip_config            = var.ip_config
  subnet               = var.backend_subnet
  public_ip            = var.b_public_ip
}

module "kv" {
  depends_on          = [module.rg]
  source              = "../Modules/Key_vault"
  resource_group_name = var.resource_group_name
  location            = var.location
  kv_name             = var.kv_name

}

module "kvs" {
  depends_on          = [module.kv]
  source              = "../Modules/key_vault_secret"
  resource_group_name = var.resource_group_name
  kv_name             = var.kv_name
  username            = var.username
  password            = var.password
  vmusername          = var.vmusername
  vmpassword          = var.vmpassword
}

module "vm" {
  depends_on           = [module.rg, module.nic1, module.kvs]
  source               = "../Modules/Virtual_machine"
  resource_group_name  = var.resource_group_name
  location             = var.location
  nic_name             = var.f_nic_name
  vm_name              = var.f_vm_name
  vm_size              = var.vm_size
  publisher            = var.publisher
  offer                = var.offer
  sku                  = var.sku
  caching              = var.caching
  storage_account_type = var.storage_account_type
  key_vault            = var.kv_name
  username             = var.username
  password             = var.password
}

module "vm1" {
  depends_on           = [module.rg, module.nic2, module.kvs]
  source               = "../Modules/Virtual_machine"
  resource_group_name  = var.resource_group_name
  location             = var.location
  nic_name             = var.b_nic_name
  vm_name              = var.b_vm_name
  vm_size              = var.vm_size
  publisher            = var.publisher
  offer                = var.offer
  sku                  = var.sku
  caching              = var.caching
  storage_account_type = var.storage_account_type
  key_vault            = var.kv_name
  username             = var.username
  password             = var.password
}


