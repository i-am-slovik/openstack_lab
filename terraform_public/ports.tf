# ports

resource "openstack_networking_port_v2" "slovik_dmz_ports" {
  count      = 2
  name       = element(["slovik_ingress_node", "slovik_jumpbox"], count.index)
  network_id = openstack_networking_network_v2.slovik_dmz_network.id
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.slovik_dmz_subnet.id
    ip_address = element([var.dmz_ips.ingress_node, var.dmz_ips.jumpbox], count.index)
  }
}

resource "openstack_networking_port_v2" "slovik_internal_management_ports" {
  count      = 11
  name       = element([
    "slovik_internal_https_ingress_node",
    "slovik_internal_jumpbox",
    "slovik_zabbix",
    "slovik_internal_management_13",
    "slovik_internal_management_14",
    "slovik_internal_management_15",
    "slovik_internal_management_16",
    "slovik_internal_management_17",
    "slovik_internal_management_18",
    "slovik_internal_management_19",
    "slovik_internal_management_20"
  ], count.index)
  network_id = openstack_networking_network_v2.slovik_internal_management.id
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.slovik_internal_management_subnet.id
    ip_address = element([
      var.internal_ips.internal_https_ingress_node,
      var.internal_ips.internal_jumpbox,
      var.internal_ips.zabbix,
      var.internal_ips.internal_management_13,
      var.internal_ips.internal_management_14,
      var.internal_ips.internal_management_15,
      var.internal_ips.internal_management_16,
      var.internal_ips.internal_management_17,
      var.internal_ips.internal_management_18,
      var.internal_ips.internal_management_19,
      var.internal_ips.internal_management_20
    ], count.index)
  }
}

resource "openstack_networking_port_v2" "slovik_internal_https_ports" {
  count      = 11
  name       = element([
    "slovik_internal_https_ingress_node",
    "slovik_internal_https_11",
    "slovik_internal_https_12",
    "slovik_internal_https_13",
    "slovik_internal_https_14",
    "slovik_internal_https_15",
    "slovik_internal_https_16",
    "slovik_internal_https_17",
    "slovik_internal_https_18",
    "slovik_internal_https_19",
    "slovik_internal_https_20"
  ], count.index)
  network_id = openstack_networking_network_v2.slovik_internal_https.id
  fixed_ip {
    subnet_id  = openstack_networking_subnet_v2.slovik_internal_https_subnet.id
    ip_address = element([
      var.internal_ips.internal_https_ingress_node,
      var.internal_ips.internal_https_11,
      var.internal_ips.internal_https_12,
      var.internal_ips.internal_https_13,
      var.internal_ips.internal_https_14,
      var.internal_ips.internal_https_15,
      var.internal_ips.internal_https_16,
      var.internal_ips.internal_https_17,
      var.internal_ips.internal_https_18,
      var.internal_ips.internal_https_19,
      var.internal_ips.internal_https_20
    ], count.index)
  }
}

