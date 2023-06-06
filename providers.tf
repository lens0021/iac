variable "oci_private_key" {
  type      = string
  sensitive = true
}

variable "oci_region" {
  default = "ap-seoul-1"
}

terraform {
  required_version = "~> 1.0"

  backend "remote" {
    organization = "lens0021"

    workspaces {
      name = "iac"
    }
  }
}

provider "oci" {
  auth         = "APIKey"
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaamsyx65yzn6dlrfg2moqhmfhdb3bhipgwtb326vhw62xtb4jmu5za"
  user_ocid    = "ocid1.user.oc1..aaaaaaaaqp2n5eo7an2mexklqddkix6vdew22llbzj65lgfgiqsnb6eippva"
  private_key  = var.oci_private_key
  fingerprint  = "46:bd:cb:be:19:24:a7:70:7b:96:a7:d9:58:a7:b0:67"
  region       = var.oci_region
}
