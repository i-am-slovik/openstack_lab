#IPs

variable "public_ips" {
  type = object({
    my_home_ip         = string
    my_work_ip         = string
    my_phone_ip        = string
    github_webhook_ips = list(string)
  })
}

variable "dmz_ips" {
  type = object({
    ingress_node = string
    jumpbox      = string
  })
}

variable "internal_ips" {
  type = object({
    internal_https_ingress_node = string
    internal_jumpbox            = string
    zabbix                      = string
    internal_management_13      = string
    internal_management_14      = string
    internal_management_15      = string
    internal_management_16      = string
    internal_management_17      = string
    internal_management_18      = string
    internal_management_19      = string
    internal_management_20      = string
    internal_https_11           = string
    internal_https_12           = string
    internal_https_13           = string
    internal_https_14           = string
    internal_https_15           = string
    internal_https_16           = string
    internal_https_17           = string
    internal_https_18           = string
    internal_https_19           = string
    internal_https_20           = string
  })
}

#networks

variable "networks" {
  type = object({
    slovik_dmz_network           = object({ cidr = string, dhcp = bool })
    slovik_internal_management   = object({ cidr = string, dhcp = bool })
    slovik_internal_https        = object({ cidr = string, dhcp = bool })
    internet                     = string
  })
}

#key

variable "slovik_key" {
  type        = string
  description = "Name of the existing OpenStack keypair to use"
  default     = "slovik"
}
