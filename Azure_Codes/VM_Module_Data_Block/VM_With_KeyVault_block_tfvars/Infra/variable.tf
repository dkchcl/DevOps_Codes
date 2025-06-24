variable "resource_group_name" {
  description = "rg name"
  type        = string
}

variable "location" {
  description = "location"
  type        = string
}

variable "virtual_network_name" {
  description = "virtual network"
  type        = string
}

variable "address_space" {
  description = "address space"
  type        = list(string)
}

variable "frontend_subnet" {
  description = "frontend subnet"
  type        = string
}

variable "address_prefixes_f" {
  description = "address prefixes"
  type        = list(string)
}

variable "backend_subnet" {
  description = "b subnet"
  type        = string
}

variable "address_prefixes_b" {
  description = "address prefixes"
  type        = list(string)
}

variable "nsg_name" {
  description = "nsg"
  type        = string
}

variable "f_public_ip" {
  description = "public ip"
  type        = string
}

variable "b_public_ip" {
  description = "public ip"
  type        = string
}

variable "f_nic_name" {
  description = "nic"
  type        = string
}

variable "b_nic_name" {
  description = "nic"
  type        = string
}

variable "ip_config" {
  description = "ip config name"
  type        = string
}

variable "f_vm_name" {
  description = "vm name"
  type        = string
}

variable "b_vm_name" {
  description = "vm name"
  type        = string
}

variable "vm_size" {
  description = "vm name"
  type        = string
}

variable "publisher" {}

variable "offer" {}

variable "sku" {}

variable "f_os_disk_name" {}

variable "b_os_disk_name" {}

variable "caching" {}

variable "create_option" {}

variable "managed_disk_type" {}

variable "f_computer_name" {}

variable "b_computer_name" {}

# variable "key_vault" {}

# variable "admin_username" {}

# variable "admin_password" {}


variable "username" {
  description = "kvs name"
  type = string
}

variable "vmusername" {
  description = "kvs_value_name"
  type = string
}

variable "password" {
  description = "kv name"
  type = string
}

variable "vmpassword" {
  description = "kv name"
  type = string
}

variable "kv_name" {
  description = "kv name"
  type = string
  
}

