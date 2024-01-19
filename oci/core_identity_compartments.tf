resource "oci_identity_compartment" "blue" {
  compartment_id = data.oci_identity_compartment.root.id
  description    = "A compartment"
  name           = "blue"
}

data "oci_identity_compartment" "root" {
  id = var.tenancy_ocid
}
