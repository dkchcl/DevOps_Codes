variable "resource_group_name" {
  description = "rg name"
  type = string
}

variable "username" {
  description = "username for the VM"
  type = string
}

variable "vmusername" {
  description = "value for the username"
  type = string
}

variable "password" {
  description = "password for the VM"
  type = string
}

variable "vmpassword" {
  description = " value for the password"
  type = string
}
variable "kv_name" {
  description = "kv name"
  type        = string
}