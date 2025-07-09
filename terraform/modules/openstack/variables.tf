variable "owner" {
  description = "Owner credentials and identifiers"
  type = object({
    name       = string
    ssh_key_id = string
    app_cred   = string
    secret     = string
  })
}

variable "vms" {
  description = "Map of VM configurations"
  type = map(object({
    count    = number
    networks = map(string)
  }))
}

variable "networks" {
  description = "Available network definitions"
  type = map(object({
    description = string
    dhcp        = bool
    subnet      = string
  }))
}