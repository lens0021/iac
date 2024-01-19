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
