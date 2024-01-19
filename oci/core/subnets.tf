resource "oci_core_subnet" "blue" {
  cidr_block     = "10.1.20.0/24"
  compartment_id = oci_identity_compartment.blue.id
  vcn_id         = oci_core_vcn.blue.id
}
