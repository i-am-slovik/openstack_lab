variable "my_home_ip" {}
variable "my_work_ip" {}
variable "my_phone_ip" {}
variable "github_webhook_ips" {}

resource "openstack_networking_secgroup_v2" "slovik_external_jumpbox" {
  name        = "slovik_external_jumpbox"
  description = "SSH from home, work, phone"
}

resource "openstack_networking_secgroup_rule_v2" "jumpbox_ssh_home" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_jumpbox.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.my_home_ip
  ethertype         = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "jumpbox_ssh_work" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_jumpbox.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.my_work_ip
  ethertype         = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "jumpbox_ssh_phone" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_jumpbox.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.my_phone_ip
  ethertype         = "IPv4"
}

resource "openstack_networking_secgroup_v2" "slovik_external_https_public" {
  name        = "slovik_external_https_public"
  description = "HTTPS open to all"
}

resource "openstack_networking_secgroup_rule_v2" "https_public" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_https_public.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
  ethertype         = "IPv4"
}

resource "openstack_networking_secgroup_v2" "slovik_external_https_webhook" {
  name        = "slovik_external_https_webhook"
  description = "HTTPS only from GitHub"
}

resource "openstack_networking_secgroup_rule_v2" "github_webhook_ingress" {
  for_each = toset(var.github_webhook_ips)

  direction         = "ingress"
  security_group_id = openstack_networking_secgroup_v2.slovik_external_https_webhook.id
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = each.value
  ethertype         = "IPv4"
}

resource "openstack_networking_secgroup_v2" "slovik_external_https_trusted" {
  name        = "slovik_external_https_trusted"
  description = "HTTPS from trusted IPs"
}

resource "openstack_networking_secgroup_rule_v2" "https_trusted_home" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_https_trusted.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.my_home_ip
  ethertype         = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "https_trusted_work" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_https_trusted.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.my_work_ip
  ethertype         = "IPv4"
}

resource "openstack_networking_secgroup_rule_v2" "https_trusted_phone" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_https_trusted.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.my_phone_ip
  ethertype         = "IPv4"
}
