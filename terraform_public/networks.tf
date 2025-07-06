# networks dmz

resource "openstack_networking_network_v2" "slovik_dmz_network" {
  name = "slovik_dmz_network"
}

resource "openstack_networking_subnet_v2" "slovik_dmz_subnet" {
  name       = "slovik_dmz_subnet"
  network_id = openstack_networking_network_v2.slovik_dmz_network.id
  cidr       = var.networks.slovik_dmz_network.cidr
  ip_version = 4
  enable_dhcp       = var.networks.slovik_dmz_network.dhcp
}
# networks intermediate 

resource "openstack_networking_network_v2" "slovik_intermediate_management" {
  name = "slovik_intermediate_management"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "slovik_intermediate_management" {
  name            = "slovik_intermediate_management_subnet"
  network_id      = openstack_networking_network_v2.slovik_intermediate_management.id
  cidr            = var.networks.slovik_intermediate_management.cidr
  ip_version      = 4
  enable_dhcp     = var.networks.slovik_intermediate_management.dhcp
}

resource "openstack_networking_network_v2" "slovik_intermediate_https" {
  name = "slovik_intermediate_https"
  admin_state_up = true
}

resource "openstack_networking_subnet_v2" "slovik_intermediate_https" {
  name            = "slovik_intermediate_https_subnet"
  network_id      = openstack_networking_network_v2.slovik_intermediate_https.id
  cidr            = var.networks.slovik_intermediate_https.cidr
  ip_version      = 4
  enable_dhcp     = var.networks.slovik_intermediate_https.dhcp
}

# networks internal 

resource "openstack_networking_network_v2" "slovik_internal_management" {
  name = "slovik_internal_management"
}

resource "openstack_networking_subnet_v2" "slovik_internal_management_subnet" {
  name       = "slovik_internal_management_subnet"
  network_id = openstack_networking_network_v2.slovik_internal_management.id
  cidr       = var.networks.slovik_internal_management.cidr
  ip_version = 4
  enable_dhcp       = var.networks.slovik_internal_management.dhcp
}

resource "openstack_networking_network_v2" "slovik_internal_https" {
  name = "slovik_internal_https"
}

resource "openstack_networking_subnet_v2" "slovik_internal_https_subnet" {
  name       = "slovik_internal_https_subnet"
  network_id = openstack_networking_network_v2.slovik_internal_https.id
  cidr       = var.networks.slovik_internal_https.cidr
  ip_version = 4
  enable_dhcp       = var.networks.slovik_internal_https.dhcp
}
