data "oci_identity_compartment" "root" {
  id = "ocid1.tenancy.oc1..aaaaaaaamsyx65yzn6dlrfg2moqhmfhdb3bhipgwtb326vhw62xtb4jmu5za"
}

resource "oci_identity_compartment" "blue" {
  compartment_id = data.oci_identity_compartment.root.id
  description    = "A compartment"
  name           = "blue"
}

data "oci_identity_availability_domain" "ad1" {
  compartment_id = data.oci_identity_compartment.root.id
  ad_number      = 1
}

resource "oci_core_vcn" "blue" {
  cidr_block     = "10.1.0.0/16"
  compartment_id = oci_identity_compartment.blue.id
}

resource "oci_core_subnet" "blue" {
  cidr_block     = "10.1.20.0/24"
  compartment_id = oci_identity_compartment.blue.id
  vcn_id         = oci_core_vcn.blue.id
}

resource "oci_core_instance" "blue" {
  compartment_id      = oci_identity_compartment.blue.id
  availability_domain = data.oci_identity_availability_domain.ad1.id
  shape               = data.oci_core_images.ubuntu_minimal.shape

  shape_config {
    ocpus         = 2
    memory_in_gbs = 6
  }

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu_minimal.images[0].id
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.blue.id
  }

  metadata = {
    user_data = file("oci_core_instance_user_data.sh")
  }

  lifecycle {
    ignore_changes = [
      source_details,
    ]
  }
}

data "oci_core_images" "ubuntu_minimal" {
  compartment_id = oci_identity_compartment.blue.id

  # VM.Standard.A1.Flex: Arm-based
  # VM.Standard.E2.1.Micro
  shape = "VM.Standard.E2.1.Micro"

  operating_system = "Canonical Ubuntu"
  sort_by          = "TIMECREATED"
}

data "oci_core_instances" "all" {
  compartment_id = oci_identity_compartment.blue
}
# Output the result
output "oci_all_core_instances" {
  value = data.oci_core_instances.all
}
