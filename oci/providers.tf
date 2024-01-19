provider "oci" {
  auth         = "APIKey"
  tenancy_ocid = var.tenancy_ocid
  user_ocid    = var.user_ocid
  private_key  = var.oci_private_key
  fingerprint  = var.oci_fingerprint
  region       = var.oci_region
}
