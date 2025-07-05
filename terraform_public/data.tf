#data

data "openstack_networking_port_v2" "slovik_dmz_ports" {
  for_each = {
    slovik_ingress_node = "slovik_ingress_node"
    slovik_jumpbox      = "slovik_jumpbox"
  }
  name = each.value
}