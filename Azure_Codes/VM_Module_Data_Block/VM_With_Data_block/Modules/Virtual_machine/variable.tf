variable "resource_group_name" {
  description = "rg name"
  type = string
}

variable "location" {
  description = "location"
  type = string
}

variable "nic_name" {
  description = "nic"
  type = string
}

variable "vm_name" {
  description = "vm name"
  type = string
}

variable "vm_size" {
  description = "vm name"
  type = string
}

variable "publisher" {}

variable "offer" {}

variable "sku" {}

variable "os_disk_name" {}

variable "caching" {}

variable "create_option" {}

variable "managed_disk_type" {}

variable "computer_name" {}

variable "admin_username" {}

variable "admin_password" {}

# variable "data_nic" {}

# variable "virtual_network_name" {
#   description = "virtual network"
#   type = string
# }

# variable "subnet" {}

# variable "public_ip" {
#   description = "public ip"
#   type = string
# }