resource "oci_core_public_ip" "blue" {
  compartment_id = oci_identity_compartment.blue.id
  lifetime       = "RESERVED"
  private_ip_id  = data.oci_core_private_ips.blue.private_ips[0].id
}
