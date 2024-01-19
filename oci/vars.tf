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

variable "tenancy_ocid" {
  default = "ocid1.tenancy.oc1..aaaaaaaamsyx65yzn6dlrfg2moqhmfhdb3bhipgwtb326vhw62xtb4jmu5za"
}

variable "user_ocid" {
  default = "ocid1.user.oc1..aaaaaaaaqp2n5eo7an2mexklqddkix6vdew22llbzj65lgfgiqsnb6eippva"
}
