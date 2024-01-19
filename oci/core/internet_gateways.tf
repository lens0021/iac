resource "oci_core_internet_gateway" "blue" {
  compartment_id = oci_identity_compartment.blue.id
  vcn_id         = oci_core_vcn.blue.id
}
