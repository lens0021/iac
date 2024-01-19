output "oci_core_instance_blue_public_ip" {
  value = oci_core_instance.blue.public_ip
}

output "oci_core_instance_blue_reserved_id" {
  value = oci_core_public_ip.blue.ip_address
}
