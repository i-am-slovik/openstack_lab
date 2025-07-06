# ports

locals {
  slovik_dmz_ports_map = {
    "slovik_ingress_node_port" = var.dmz_ips.ingress_node
    "slovik_jumpbox_port"      = var.dmz_ips.jumpbox
  }

  slovik_internal_management_ports_map = {
    "slovik_internal_management_internal_ingress_node_port" = var.internal_ips.internal_management_internal_ingress_node
    "slovik_internal_management_internal_jumpbox_port"      = var.internal_ips.internal_management_internal_jumpbox
    "slovik_internal_management_zabbix_port"                = var.internal_ips.internal_management_zabbix
    "slovik_internal_management_13_port"                    = var.internal_ips.internal_management_13
    "slovik_internal_management_14_port"                    = var.internal_ips.internal_management_14
    "slovik_internal_management_15_port"                    = var.internal_ips.internal_management_15
    "slovik_internal_management_16_port"                    = var.internal_ips.internal_management_16
    "slovik_internal_management_17_port"                    = var.internal_ips.internal_management_17
    "slovik_internal_management_18_port"                    = var.internal_ips.internal_management_18
    "slovik_internal_management_19_port"                    = var.internal_ips.internal_management_19
    "slovik_internal_management_20_port         "           = var.internal_ips.internal_management_20
  }

  slovik_internal_https_ports_map = {
    "slovik_internal_https_internal_ingress_node_port"  = var.internal_ips.internal_https_internal_ingress_node
    "slovik_internal_https_11_port"                     = var.internal_ips.internal_https_11
    "slovik_internal_https_12_port"                     = var.internal_ips.internal_https_12
    "slovik_internal_https_13_port"                     = var.internal_ips.internal_https_13
    "slovik_internal_https_14_port"                     = var.internal_ips.internal_https_14
    "slovik_internal_https_15_port"                     = var.internal_ips.internal_https_15
    "slovik_internal_https_16_port"                     = var.internal_ips.internal_https_16
    "slovik_internal_https_17_port"                     = var.internal_ips.internal_https_17
    "slovik_internal_https_18_port"                     = var.internal_ips.internal_https_18
    "slovik_internal_https_19_port"                     = var.internal_ips.internal_https_19
    "slovik_internal_https_20_port"                     = var.internal_ips.internal_https_20
  }
}

resource "openstack_networking_port_v2" "slovik_dmz_ports" {
  for_each  = local.slovik_dmz_ports_map
  name      = each.key
  network_id = openstack_networking_network_v2.slovik_dmz_network.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.slovik_dmz_subnet.id
    ip_address = each.value
  }
}

resource "openstack_networking_port_v2" "slovik_internal_management_ports" {
  for_each  = local.slovik_internal_management_ports_map
  name      = each.key
  network_id = openstack_networking_network_v2.slovik_internal_management.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.slovik_internal_management_subnet.id
    ip_address = each.value
  }
}

resource "openstack_networking_port_v2" "slovik_internal_https_ports" {
  for_each  = local.slovik_internal_https_ports_map
  name      = each.key
  network_id = openstack_networking_network_v2.slovik_internal_https.id

  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.slovik_internal_https_subnet.id
    ip_address = each.value
  }
}
