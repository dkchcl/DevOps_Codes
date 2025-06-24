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

module "nic1" {
  depends_on           = [module.f_subnet, module.f_pip]
  source               = "../Modules/nic"
  nic_name             = "nic1"
  resource_group_name  = "dkc-rg-01"
  location             = "central india"
  virtual_network_name = "todovnet"
  ip_config            = "testconfig"
  subnet               = "subnet1"
  public_ip            = "frontend_pip"
}

module "nic2" {
  depends_on           = [module.b_subnet, module.b_pip]
  source               = "../Modules/nic"
  nic_name             = "nic2"
  resource_group_name  = "dkc-rg-01"
  location             = "central india"
  virtual_network_name = "todovnet"
  ip_config            = "testconfig"
  subnet               = "subnet2"
  public_ip            = "backend_pip"
}

module "key_vault" {
  depends_on          = [module.rg]
  source              = "../Modules/key_vault"
  resource_group_name = "dkc-rg-01"
  location            = "central india"
  kv_name             = "todovault23"
}

module "key_vault_secret" {
  depends_on          = [module.key_vault]
  source              = "../Modules/key_vault_secret"
  resource_group_name = "dkc-rg-01"
  kv_name             = "todovault23"
  username            = "vmusername"
  adminusername       = "adminusername"
  password            = "vmpassword"
  adminpassword       = "Bbpl@#2304"
}

module "key_vault_secret1" {
  depends_on          = [module.key_vault]
  source              = "../Modules/key_vault_secret"
  resource_group_name = "dkc-rg-01"
  kv_name             = "todovault23"
  username            = "sqlusername"
  adminusername       = "sqladmin"
  password            = "sqlpassword"
  adminpassword       = "Bbpl@#23041"
}

module "sql_server_name" {
  depends_on          = [module.rg, module.key_vault_secret1]
  source              = "../Modules/sql_server"
  resource_group_name = "dkc-rg-01"
  location            = "central india"
  sql_server_name     = "todovmssqlserver1"
  key_vault           = "todovault23"
  username            = "sqlusername"
  password            = "sqlpassword"
}

module "sql_database" {
  depends_on          = [module.sql_server_name]
  source              = "../Modules/sql_database"
  resource_group_name = "dkc-rg-01"
  sql_server_name     = "todovmssqlserver1"
  sql_database_name   = "todovmssqldb"
}

module "vm" {
  depends_on           = [module.rg, module.nic1, module.key_vault_secret]
  source               = "../Modules/Virtual_machine"
  resource_group_name  = "dkc-rg-01"
  location             = "central india"
  nic_name             = "nic1"
  vm_name              = "frontendvm"
  size                 = "Standard_D2_v3"
  publisher            = "Canonical"
  offer                = "0001-com-ubuntu-server-jammy"
  sku                  = "22_04-lts"
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  key_vault            = "todovault23"
  username             = "vmusername"
  password             = "vmpassword"
}

module "vm1" {
  depends_on           = [module.rg, module.nic2, module.key_vault_secret]
  source               = "../Modules/Virtual_machine"
  resource_group_name  = "dkc-rg-01"
  location             = "central india"
  nic_name             = "nic2"
  vm_name              = "backendvm"
  size                 = "Standard_D2_v3"
  publisher            = "Canonical"
  offer                = "0001-com-ubuntu-server-jammy"
  sku                  = "22_04-lts"
  caching              = "ReadWrite"
  storage_account_type = "Standard_LRS"
  key_vault            = "todovault23"
  username             = "vmusername"
  password             = "vmpassword"
}
