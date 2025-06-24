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

# variable "os_disk_name" {}

variable "caching" {}

# variable "create_option" {}

variable "storage_account_type" {}

# variable "computer_name" {}

variable "key_vault" {}

variable "username" {}

variable "password" {}

