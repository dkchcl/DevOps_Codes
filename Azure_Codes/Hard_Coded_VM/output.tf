output "vm_public_ip" {
  value = azurerm_public_ip.public-ip.ip_address
}
