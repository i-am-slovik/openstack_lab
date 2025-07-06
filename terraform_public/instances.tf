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
    port = openstack_networking_port_v2.slovik_intermediate_https_ports["slovik_intermediate_https_external_ingress_node_port"].id
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
    port = openstack_networking_port_v2.slovik_intermediate_management_ports["slovik_intermediate_management_external_jumpbox_port"].id
  }

  security_groups = ["slovik_dmz_jumpbox"]
}

# instances internal basic

# Instance: slovik_internal_jumpbox
resource "openstack_compute_instance_v2" "slovik_internal_jumpbox" {
  name        = "slovik_internal_jumpbox"
  image_id    = "31f8a181-633b-42ee-8c26-8c2d2656db49"
  flavor_id   = "c4-4"
  key_pair    = var.slovik_key

  security_groups = [
    "slovik_internal_jumpbox_ingress",
    "slovik_internal_management_traffic",
  ]

  network {
    port = openstack_networking_port_v2.slovik_intermediate_management_internal_jumpbox_port.id
  }

  network {
    port = openstack_networking_port_v2.slovik_internal_management_internal_jumpbox_port.id
  }
}

# Instance: slovik_internal_ingress_node
resource "openstack_compute_instance_v2" "slovik_internal_ingress_node" {
  name        = "slovik_internal_ingress_node"
  image_id    = "31f8a181-633b-42ee-8c26-8c2d2656db49"
  flavor_id   = "c4-4"
  key_pair    = var.slovik_key

  security_groups = [
    "slovik_internal_https_ingress",
    "slovik_internal_management_traffic",
    "slovik_internal_https",
  ]

  network {
    port = openstack_networking_port_v2.slovik_intermediate_https_internal_ingress_node_port.id
  }

  network {
    port = openstack_networking_port_v2.slovik_internal_management_internal_ingress_node_port.id
  }

  network {
    port = openstack_networking_port_v2.slovik_internal_https_internal_ingress_node_port.id
  }
}

