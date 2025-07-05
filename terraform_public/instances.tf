#instances in dmz

resource "openstack_compute_instance_v2" "slovik_ingress_node" {
  name            = "slovik_ingress_node"
  image_name      = "Ubuntu Server 24.04 LTS Cloud Image"
  flavor_name     = "c.4VCPU_4GB"
  key_pair        = var.slovik_key

  network {
    port = openstack_networking_port_v2.slovik_dmz_ports["slovik_ingress_node_port"].id
  }

  security_groups = ["slovik_dmz_https_trusted", "slovik_dmz_https_webhook"]
}

resource "openstack_compute_instance_v2" "slovik_jumpbox" {
  name            = "slovik_jumpbox"
  image_name      = "Ubuntu Server 24.04 LTS Cloud Image"
  flavor_name     = "c.4VCPU_4GB"
  key_pair        = var.slovik_key

  network {
    port = openstack_networking_port_v2.slovik_dmz_ports["slovik_jumpbox_port"].id
  }

  security_groups = ["slovik_dmz_jumpbox"]
}

