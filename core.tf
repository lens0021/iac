data "oci_identity_compartment" "root" {
  id = "ocid1.tenancy.oc1..aaaaaaaamsyx65yzn6dlrfg2moqhmfhdb3bhipgwtb326vhw62xtb4jmu5za"
}

resource "oci_identity_compartment" "cron" {
  compartment_id = data.oci_identity_compartment.root.id
  description    = "A compartment for cron"
  name           = "cron"
}

resource "oci_identity_domain" "cron" {
  compartment_id = oci_identity_compartment.cron.id
  description    = "A domain"
  display_name   = "cron"
  home_region    = var.oci_region
  license_type   = "free"
}

resource "oci_core_instance" "blue" {
  compartment_id      = oci_identity_compartment.cron.id
  availability_domain = oci_identity_domain.cron.id
  shape               = "VM.Standard.A1.Flex"

  source_details {
    source_type = "image"
    source_id   = data.oci_core_images.ubuntu_minimal.images[0].id
  }

  lifecycle {
    ignore_changes = [
      source_details[0].source_id,
    ]
  }
}

data "oci_core_images" "ubuntu_minimal" {
  compartment_id = oci_identity_compartment.cron.id

  operating_system = "Canonical Ubuntu"
  shape            = "VM.Standard.A1.Flex"
  sort_by          = "TIMECREATED"
}
