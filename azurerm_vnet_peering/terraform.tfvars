vnet_peerings = { 

    tej1 = {

  name                         = "vnet-peering"
  resource_group_name          = "rg-king"
  virtual_network_name         =  "vnet"
  remote_virtual_network_id    =  "/subscriptions/ad260aed-6495-48f9-bbbb-54f0f48091e9/resourceGroups/rg-queen/providers/Microsoft.Network/virtualNetworks/vent1"

    }
}