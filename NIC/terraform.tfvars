network_interfaces = {
  nic1 = {
    name                  = "nic-web"
    location              = "eastus"
    resource_group_name   = "rg-king"
    ip_config_name        = "testConfiguration"
    subnet_id             = "/subscriptions/ad260aed-6495-48f9-bbbb-54f0f48091e9/resourceGroups/rg-king/providers/Microsoft.Network/virtualNetworks/vnet/subnets/sub-king"
    private_ip_allocation = "Dynamic"
    public_ip_id          = "/subscriptions/ad260aed-6495-48f9-bbbb-54f0f48091e9/resourceGroups/rg-king/providers/Microsoft.Network/publicIPAddresses/pip-web"
  }

  nic2 = {
    name                  = "nic-app"
    location              = "eastus"
    resource_group_name   = "rg-king"
    ip_config_name        = "testConfiguration"
    subnet_id             = "/subscriptions/ad260aed-6495-48f9-bbbb-54f0f48091e9/resourceGroups/rg-king/providers/Microsoft.Network/virtualNetworks/vnet/subnets/sub-king"
    private_ip_allocation = "Dynamic"
    public_ip_id          = "/subscriptions/ad260aed-6495-48f9-bbbb-54f0f48091e9/resourceGroups/rg-king/providers/Microsoft.Network/publicIPAddresses/pip-app"
  }
}
