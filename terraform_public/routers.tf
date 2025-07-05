#routers

resource "openstack_networking_router_v2" "slovik_router" {
  name = "slovik_router"
  admin_state_up = true
  external_gateway = var.networks.internet
}

resource "openstack_networking_router_interface_v2" "dmz_interface" {
  router_id = openstack_networking_router_v2.slovik_router.id
  subnet_id = var.networks.slovik_dmz_network.subnet_id
}