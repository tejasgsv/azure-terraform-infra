resource "azurerm_public_ip" "pip" {
  for_each = var.public_ips

  name                = each.value.name
  resource_group_name = var.resource_group_name
  location            = var.location

  allocation_method = "Static"
  sku               = "Standard"
}