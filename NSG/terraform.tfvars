nsg = {

name                = "nsg"
location            = "eastus"
resource_group_name = "rg-king"
}

network_security_rule = {

ssh = {


name                        = "Allow-SSH"
priority                    = 100
direction                   = "Inbound"
access                      = "Allow"
protocol                    = "Tcp"
source_port_range           = "*"
destination_port_range      = "22"
source_address_prefix       = "*"
destination_address_prefix  = "*"
resource_group_name         = "rg-king"


}

http = {


name                        = "Allow-HTTP"
priority                    = 110
direction                   = "Inbound"
access                      = "Allow"
protocol                    = "Tcp"
source_port_range           = "*"
destination_port_range      = "80"
source_address_prefix       = "*"
destination_address_prefix  = "*"
resource_group_name         = "rg-king"


}
}
