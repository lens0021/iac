resource "oci_core_vnic_attachment" "blue" {
  instance_id = oci_core_instance.blue.id

  create_vnic_details {
    private_ip = oci_core_private_ip.blue.ip_address
    subnet_id  = oci_core_subnet.blue.id
  }
}
