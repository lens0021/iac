data "oci_core_images" "ubuntu_minimal_e2" {
  compartment_id = oci_identity_compartment.blue.id

  # VM.Standard.A1.Flex: Arm-based
  # VM.Standard.E2.1.Micro
  shape = "VM.Standard.E2.1.Micro"

  operating_system = "Canonical Ubuntu"
  sort_by          = "TIMECREATED"
}

data "oci_core_images" "ubuntu_minimal_a1" {
  compartment_id = oci_identity_compartment.blue.id

  # VM.Standard.A1.Flex: Arm-based
  # VM.Standard.E2.1.Micro
  shape = "VM.Standard.A1.Flex"

  operating_system = "Canonical Ubuntu"
  sort_by          = "TIMECREATED"
}
