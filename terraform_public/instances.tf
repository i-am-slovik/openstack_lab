# instances in dmz

resource "openstack_compute_instance_v2" "slovik_ingress_node" {
  name      = "slovik_ingress_node"
  image_id  = "31f8a181-633b-42ee-8c26-8c2d2656db49"
  flavor_id = "c4-4"
  key_pair  = var.slovik_key

  network {
    port = openstack_networking_port_v2.slovik_dmz_ports["slovik_ingress_node_port"].id
  }

  network {
    port = openstack_networking_port_v2.slovik_internal_ports["slovik_internal_https_external_ingress_node_port"].id
  }

  security_groups = ["slovik_dmz_https_trusted", "slovik_dmz_https_webhook"]
}

resource "openstack_compute_instance_v2" "slovik_jumpbox" {
  name      = "slovik_jumpbox"
  image_id  = "31f8a181-633b-42ee-8c26-8c2d2656db49"
  flavor_id = "c4-4"
  key_pair  = var.slovik_key

  network {
    port = openstack_networking_port_v2.slovik_dmz_ports["slovik_jumpbox_port"].id
  }

  network {
    port = openstack_networking_port_v2.slovik_internal_ports["slovik_internal_management_external_jumpbox"].id
  }

  security_groups = ["slovik_dmz_jumpbox"]
}