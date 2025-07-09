resource "openstack_networking_subnet_v2" "subnets" {
  for_each = {
    for name, net in var.networks : name => net if net.subnet != ""
  }

  name            = each.key
  network_id      = openstack_networking_network_v2.networks[each.key].id
  cidr            = each.value.subnet
  ip_version      = 4
  enable_dhcp     = each.value.dhcp
}