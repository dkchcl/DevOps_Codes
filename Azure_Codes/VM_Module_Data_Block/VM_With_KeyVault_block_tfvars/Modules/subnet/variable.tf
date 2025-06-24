variable "resource_group_name" {
  description = "rg name"
  type = string
}

variable "virtual_network_name" {
  description = "virtual network"
  type = string
}

variable "subnet" {
  description = "subnet"
  type = string
}

variable "address_prefixes" {
  description = "address prefixes"
  type = list(string)
}