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

variable "ip_config" {
  description = "ip config name"
  type = string
}

variable "virtual_network_name" {
  description = "virtual network"
  type = string
}

variable "subnet" {}

variable "public_ip" {
  description = "public ip"
  type = string
}