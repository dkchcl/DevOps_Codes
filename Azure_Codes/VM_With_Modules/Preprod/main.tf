module "resource_group" {
  source = "../Resource_Group"
  resource_group_name = var.resource_group_name
  location = var.location
}

module "virtual_network" {
  source = "../Virtual_Network"
  depends_on = [ module.resource_group ]
  resource_group_name = var.resource_group_name
  location = var.location
  vnet_name = var.vnet_name
  vnet_address_space = var.vnet_address_space 
}

module "subnet" {
  source = "../Subnet"
  depends_on = [ module.virtual_network ]
  vnet_name = var.vnet_name
  resource_group_name = var.resource_group_name
  subnet_name = var.subnet_name
  subnet_address_prefix = var.subnet_address_prefix
}

module "nsg" {
  source = "../NSG"
  depends_on = [ module.resource_group ]
  resource_group_name = var.resource_group_name
  location = var.location
  nsg_name = var.nsg_name
}

module "subnet_nsg_assoc" {
  source = "../NSG_Assoc"
  depends_on = [ module.nsg ]
  subnet_id = module.subnet.subnet_id
  nsg_id    = module.nsg.nsg_id
}

module "public_ip" {
  source = "../Public_IP"
  depends_on = [ module.resource_group ]
  resource_group_name = var.resource_group_name
  location = var.location
  public_ip_name = var.public_ip_name
}
module "nic" {
  source = "../NIC"
  depends_on = [ module.subnet ,module.nsg ]
  resource_group_name = var.resource_group_name
  location = var.location
  nic_name = var.nic_name
  subnet_name = var.subnet_name
  public_ip_name = var.public_ip_name
  subnet_id        = module.subnet.subnet_id
  public_ip_id     = module.public_ip.public_ip_id

}
module "vm" {
  source = "../Virtual_Machine"
  depends_on = [ module.nic , module.resource_group ]
  resource_group_name = var.resource_group_name
  location = var.location
  nic_name = var.nic_name
  nic_id = module.nic.nic_id
  vm_name = var.vm_name
  vm_size = var.vm_size
  admin_username = var.admin_username
  admin_password = var.admin_password
  image_publisher = var.image_publisher
  image_offer = var.image_offer
  image_sku = var.image_sku
}

output "vm_public_ip" {
  value = module.public_ip.public_ip_address
}
