data "oci_core_vnic_attachments" "blue" {
  compartment_id = oci_identity_compartment.blue.id

  availability_domain = data.oci_identity_availability_domain.ad1.name
  instance_id         = oci_core_instance.blue.id
}
