data "oci_identity_compartment" "lens0021" {
  id = "ocid1.tenancy.oc1..aaaaaaaamsyx65yzn6dlrfg2moqhmfhdb3bhipgwtb326vhw62xtb4jmu5za"
}

data "oci_identity_availability_domain" "default" {
  compartment_id = data.oci_identity_compartment.lens0021.id
  id             = "ocid1.domain.oc1..aaaaaaaaocv5vylldre33sohcdwdu5hqigzqq3ubonb5plmqbd33lihe4oja"
}

# TODO
# resource "oci_core_instance" "blue" {
#   compartment_id = data.oci_identity_compartment.lens0021.id
# }
