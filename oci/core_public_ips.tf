# resource "oci_core_public_ip" "blue" {
#   compartment_id = oci_identity_compartment.blue.id
#   lifetime       = "RESERVED"
#   private_ip_id  = oci_core_private_ip.blue.id
# }
