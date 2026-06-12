variable "bastion_hosts" {
  type = map(object({
    name           = string
    location       = string
    resource_group_name = string
    ip_config_name = string
    subnet_id      = string
    public_ip_id   = string
  }))
}
