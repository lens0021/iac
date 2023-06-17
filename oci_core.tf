data "oci_identity_compartment" "root" {
  id = "ocid1.tenancy.oc1..aaaaaaaamsyx65yzn6dlrfg2moqhmfhdb3bhipgwtb326vhw62xtb4jmu5za"
}

resource "oci_identity_compartment" "default" {
  compartment_id = data.oci_identity_compartment.root.id
  description    = "A default compartment"
  name           = "default"
}

data "oci_identity_availability_domain" "default" {
  compartment_id = data.oci_identity_compartment.root.id
  ad_number      = 1
}

resource "oci_core_vcn" "default" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = oci_identity_compartment.default.id
}

resource "oci_core_subnet" "default" {
  availability_domain = data.oci_identity_availability_domain.default.id
  cidr_block          = "10.1.20.0/24"
  compartment_id      = oci_identity_compartment.default.id
  vcn_id              = oci_core_vcn.default.id
}

resource "oci_core_instance" "blue" {
  compartment_id      = oci_identity_compartment.default.id
  availability_domain = data.oci_identity_availability_domain.default.id
  shape               = "VM.Standard.A1.Flex"

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu_minimal.images[0].id
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.default.id
  }

  lifecycle {
    ignore_changes = [
      source_details[0].source_id,
    ]
  }
}

data "oci_core_images" "ubuntu_minimal" {
  compartment_id = oci_identity_compartment.default.id

  operating_system = "Canonical Ubuntu"
  shape            = "VM.Standard.A1.Flex"
  sort_by          = "TIMECREATED"
}
