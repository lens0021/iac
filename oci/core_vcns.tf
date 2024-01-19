resource "oci_core_vcn" "blue" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = oci_identity_compartment.blue.id
}
