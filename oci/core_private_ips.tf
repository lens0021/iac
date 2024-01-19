resource "oci_core_private_ip" "blue" {
  vnic_id = oci_core_vnic_attachment.blue
}
