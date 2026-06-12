resource "azurerm_bastion_host" "bastion" {
  for_each = var.bastion_hosts

  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = each.value.ip_config_name
    subnet_id            = each.value.subnet_id
    public_ip_address_id = each.value.public_ip_id
  }
}
