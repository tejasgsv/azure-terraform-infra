variable "network_interfaces" {
  type = map(object({
    name                     = string
    location                 = string
    resource_group_name      = string
    ip_config_name           = string
    subnet_id                = string
    private_ip_allocation    = string
    public_ip_id             = optional(string)
  }))
}
