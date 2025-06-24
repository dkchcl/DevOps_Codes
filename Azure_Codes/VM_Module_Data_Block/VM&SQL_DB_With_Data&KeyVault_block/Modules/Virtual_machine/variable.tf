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

variable "size" {
  description = "vm size"
  type = string
}

variable "publisher" {}

variable "offer" {}

variable "sku" {}

variable "caching" {}

variable "storage_account_type" {}

variable "key_vault" {}

variable "username" {}

variable "password" {}