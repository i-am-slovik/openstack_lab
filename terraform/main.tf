terraform {
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 3.0"
    }
  }
}

#auth

provider "openstack" {
  auth_url                     = var.auth_url
  application_credential_id     = var.app_cred_id
  application_credential_secret = var.app_cred_secret
  region                      = var.region
}

#public module

module "public" {
  source = "../terraform_public"

  public_ips = var.public_ips
  dmz_ips = var.dmz_ips
  intermediate_ips = var.intermediate_ips
  internal_ips = var.internal_ips
  networks = var.networks
}


