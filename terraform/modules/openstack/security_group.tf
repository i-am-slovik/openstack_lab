resource "openstack_networking_secgroup_v2" "default" {
  name        = "default"
  description = "Default security group"
}