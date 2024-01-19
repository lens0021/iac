resource "oci_core_route_table" "internet_gateway" {
  compartment_id = oci_identity_compartment.blue.id
  vcn_id         = oci_core_vcn.blue.id

  route_rules {
    network_entity_id = oci_core_internet_gateway.blue.id

    destination      = "0.0.0.0/0"
    destination_type = "CIDR_BLOCK"
  }
}

resource "oci_core_route_table_attachment" "blue" {
  subnet_id      = oci_core_subnet.blue.id
  route_table_id = oci_core_route_table.internet_gateway.id
}
