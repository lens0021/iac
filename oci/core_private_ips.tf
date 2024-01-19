data "oci_core_private_ips" "blue" {
  vnic_id = data.oci_core_vnic_attachments.blue.vnic_attachments[0].vnic_id
}
