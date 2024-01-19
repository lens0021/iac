provider "oci" {
  auth         = "APIKey"
  tenancy_ocid = "ocid1.tenancy.oc1..aaaaaaaamsyx65yzn6dlrfg2moqhmfhdb3bhipgwtb326vhw62xtb4jmu5za"
  user_ocid    = "ocid1.user.oc1..aaaaaaaaqp2n5eo7an2mexklqddkix6vdew22llbzj65lgfgiqsnb6eippva"
  private_key  = var.oci_private_key
  fingerprint  = var.oci_fingerprint
  region       = var.oci_region
}
