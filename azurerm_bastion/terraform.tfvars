bastion_hosts = {
  bastion1 = {
    name           = "bastion-host"
    location       = "eastus"
    resource_group_name = "rg-king"
    ip_config_name = "configuration"
    subnet_id      = "/subscriptions/ad260aed-6495-48f9-bbbb-54f0f48091e9/resourceGroups/rg-king/providers/Microsoft.Network/virtualNetworks/vnet/subnets/sub-king"
    public_ip_id   = "/subscriptions/ad260aed-6495-48f9-bbbb-54f0f48091e9/resourceGroups/rg-king/providers/Microsoft.Network/publicIPAddresses/pip-bastion"
  }
}
