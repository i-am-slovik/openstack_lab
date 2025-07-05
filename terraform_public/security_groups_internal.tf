# security groups internal

resource "openstack_networking_secgroup_v2" "slovik_internal_https_ingress" {
  name        = "slovik_internal_https_ingress"
  description = "Allow HTTPS from DMZ ingress node"
}

resource "openstack_networking_secgroup_rule_v2" "https_from_dmz_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "${var.dmz_ips.ingress_node}/32"
  security_group_id = openstack_networking_secgroup_v2.slovik_internal_https_ingress.id
}

resource "openstack_networking_secgroup_v2" "slovik_internal_jumpbox_ingress" {
  name        = "slovik_internal_jumpbox_ingress"
  description = "Allow SSH from DMZ jumpbox node"
}

resource "openstack_networking_secgroup_rule_v2" "ssh_from_dmz_jumpbox" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "${var.dmz_ips.jumpbox}/32"
  security_group_id = openstack_networking_secgroup_v2.slovik_internal_jumpbox_ingress.id
}

resource "openstack_networking_secgroup_v2" "slovik_internal_management_traffic" {
  name        = "slovik_internal_management_traffic"
  description = "Allow management ports from slovik_internal_management_traffic"
}

resource "openstack_networking_secgroup_rule_v2" "management_ports_from_internal_management" {
  count             = 4
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = element([22, 10050, 10051, 5432], count.index)
  port_range_max    = element([22, 10050, 10051, 5432], count.index)
  remote_ip_prefix  = var.networks.slovik_internal_management.cidr
  security_group_id = openstack_networking_secgroup_v2.slovik_internal_management_traffic.id
}

resource "openstack_networking_secgroup_rule_v2" "https_ports_from_internal_https" {
  count             = 3
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = element([443, 80, 8080], count.index)
  port_range_max    = element([443, 80, 8080], count.index)
  remote_ip_prefix  = var.networks.slovik_internal_https.cidr
  security_group_id = openstack_networking_secgroup_v2.slovik_internal_https_traffic.id
}