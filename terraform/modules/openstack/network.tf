resource "openstack_networking_network_v2" "networks" {
  for_each = var.networks

  name           = each.key
  admin_state_up = true
}