resource "oci_core_public_ip" "blue" {
  compartment_id = oci_identity_compartment.blue.id
  lifetime       = "RESERVED"
  private_ip_id  = [for ip in data.oci_core_private_ips.blue.private_ips : ip.id if ip.is_primary][0]
}
