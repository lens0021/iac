variable "oci_private_key" {
  type      = string
  sensitive = true
}

variable "oci_fingerprint" {
  type = string
}

variable "oci_region" {
  default = "ap-seoul-1"
}

terraform {
  required_version = "~> 1.0"

  required_providers {
    oci = {
      source  = "hashicorp/oci"
      version = "~> 5.0"
    }
  }

  backend "remote" {
    organization = "lens0021"

    workspaces {
      name = "iac"
    }
  }
}
