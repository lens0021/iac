resource "oci_core_private_ip" "blue" {
  subnet_id = oci_core_subnet.blue.id
}
