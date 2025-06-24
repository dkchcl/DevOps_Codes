resource "azurerm_subnet_network_security_group_association" "subnet_assoc" {
  subnet_id                 = "/subscriptions/92e22e38-2f32-450c-97de-3c896645b2da/resourceGroups/dkc-rg-02/providers/Microsoft.Network/virtualNetworks/todovnet/subnets/subnet1"
  network_security_group_id = "/subscriptions/92e22e38-2f32-450c-97de-3c896645b2da/resourceGroups/dkc-rg-02/providers/Microsoft.Network/networkSecurityGroups/todonsg"
}