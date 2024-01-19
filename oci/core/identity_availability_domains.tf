data "oci_identity_availability_domain" "ad1" {
  compartment_id = data.oci_identity_compartment.root.id
  ad_number      = 1
}
