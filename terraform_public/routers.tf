#routers

resource "openstack_networking_router_v2" "slovik_router" {
  name                = "slovik_router"
  external_network_id = var.networks.internet
}

resource "openstack_networking_router_interface_v2" "dmz_iface" {
  router_id = openstack_networking_router_v2.slovik_router.id
  subnet_id = openstack_networking_subnet_v2.slovik_dmz_subnet.id
}