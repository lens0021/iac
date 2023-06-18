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
  async = false

  compartment_id      = oci_identity_compartment.blue.id
  availability_domain = data.oci_identity_availability_domain.ad1.id
  shape               = data.oci_core_images.ubuntu_minimal.shape

  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.ubuntu_minimal.images[0].id
    boot_volume_vpus_per_gb = "10"
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

resource "oci_core_instance" "green" {
  async = false

  availability_domain = data.oci_identity_availability_domain.ad1.id

  compartment_id = oci_identity_compartment.blue.id
  defined_tags = {
    "Oracle-Tags.CreatedBy" = "default/lorentz0021@gmail.com"
    "Oracle-Tags.CreatedOn" = "2023-06-17T13:44:33.204Z"
  }
  display_name      = "green"
  extended_metadata = {}
  fault_domain      = "FAULT-DOMAIN-3"
  freeform_tags     = {}

  ipxe_script                         = ""
  is_pv_encryption_in_transit_enabled = false

  preserve_boot_volume = false
  shape                = data.oci_core_images.ubuntu_minimal.shape

  state = "RUNNING"

  agent_config {
    are_all_plugins_disabled = false
    is_management_disabled   = false
    is_monitoring_disabled   = false
  }

  availability_config {
    is_live_migration_preferred = false
    recovery_action             = "RESTORE_INSTANCE"
  }

  create_vnic_details {
    subnet_id = oci_core_subnet.blue.id
  }

  instance_options {
    are_legacy_imds_endpoints_disabled = false
  }

  launch_options {
    boot_volume_type                    = "PARAVIRTUALIZED"
    firmware                            = "UEFI_64"
    is_consistent_volume_naming_enabled = true
    network_type                        = "PARAVIRTUALIZED"
    remote_data_volume_type             = "PARAVIRTUALIZED"
  }

  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }

  source_details {
    source_id   = data.oci_core_images.ubuntu_minimal.images[0].id
    source_type = "image"
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
