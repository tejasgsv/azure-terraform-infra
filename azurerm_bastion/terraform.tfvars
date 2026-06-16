bastion_hosts = {
  bastion1 = {
    name                 = "bastion-host"
    location             = "eastus"
    resource_group_name  = "rg-king"
    virtual_network_name = "vnet"
    address_prefixes     = ["10.0.1.0/26"]
    subnet_name          = "AzureBastionSubnet"
    public_ip_name       = "bastion-pip"
    ip_config_name       = "configuration"
  }
}
