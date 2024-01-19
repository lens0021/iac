resource "oci_core_private_ip" "blue" {
  vnic_id = data.oci_core_vnic_attachment.blue.vnic_id
}
