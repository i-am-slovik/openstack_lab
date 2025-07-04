variable "my_home_ip" {}
variable "my_work_ip" {}
variable "my_phone_ip" {}
variable "github_ip" {
  default = "140.82.112.0/20"  # example GitHub IP range, adjust if needed
}

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
}

resource "openstack_networking_secgroup_rule_v2" "jumpbox_ssh_work" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_jumpbox.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.my_work_ip
}

resource "openstack_networking_secgroup_rule_v2" "jumpbox_ssh_phone" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_jumpbox.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.my_phone_ip
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
}

resource "openstack_networking_secgroup_v2" "slovik_external_https_webhook" {
  name        = "slovik_external_https_webhook"
  description = "HTTPS only from GitHub"
}

resource "openstack_networking_secgroup_rule_v2" "https_webhook" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_https_webhook.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.github_ip
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
}

resource "openstack_networking_secgroup_rule_v2" "https_trusted_work" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_https_trusted.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.my_work_ip
}

resource "openstack_networking_secgroup_rule_v2" "https_trusted_phone" {
  security_group_id = openstack_networking_secgroup_v2.slovik_external_https_trusted.id
  direction         = "ingress"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = var.my_phone_ip
}
