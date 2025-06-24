variable "resource_group_name" {
  description = "rg name"
  type = string
}

variable "virtual_network_name" {
  description = "virtual network"
  type = string
}

variable "frontend_subnet" {
  description = "frontend subnet"
  type = string
}

variable "address_prefixes" {
  description = "address prefixes"
  type = list(string)
}