terraform {
  required_version = "~> 1.0"

  backend "remote" {
    organization = "lens0021"

    workspaces {
      name = "oci"
    }
  }

  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "~> 5.0"
    }
  }
}
