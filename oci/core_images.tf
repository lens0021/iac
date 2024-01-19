data "oci_core_images" "ubuntu_minimal" {
  compartment_id = oci_identity_compartment.blue.id

  # VM.Standard.A1.Flex: Arm-based
  # VM.Standard.E2.1.Micro
  shape = "VM.Standard.E2.1.Micro"

  operating_system = "Canonical Ubuntu"
  sort_by          = "TIMECREATED"
}
