variable "rg_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-vmss"
}

variable "location" {
  description = "The Azure region where the resources will be created"
  type        = string
  default     = "West Europe"
}

variable "virtual_network_name" {
  description = "The name of the virtual network"
  type        = string
  default     = "vnet-vmss"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "subnet-vmss"
}

variable "public_ip_name" {
  description = "The name of the public IP"
  type        = string
  default     = "pipvmssdemo"
}

variable "lb_name" {
  description = "The name of the load balancer"
  type        = string
  default     = "lb-vmss"
}

variable "vmss_name" {
  description = "The name of the virtual machine scale set"
  type        = string
  default     = "vmss-demo"
}
