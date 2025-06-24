variable "resource_group_name" {
  description = "rg name"
  type = string
}

variable "location" {
  description = "location"
  type = string
}

variable "virtual_network_name" {
  description = "virtual network"
  type = string
}

variable "address_space" {
  description = "address space"
  type = list(string)
}