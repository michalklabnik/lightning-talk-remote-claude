terraform {
  required_version = "= 1.11.5"

  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "= 1.60.1"
    }
    oci = {
      source  = "oracle/oci"
      version = "= 8.3.0"
    }
  }
}
