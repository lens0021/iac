resource "oci_core_instance" "blue" {
  display_name = "blue"

  compartment_id      = oci_identity_compartment.blue.id
  availability_domain = data.oci_identity_availability_domain.ad1.name
  shape               = data.oci_core_images.ubuntu_minimal.shape

  metadata = {
    user_data = base64encode(file("core_instance_user_data.sh"))
  }

  freeform_tags = {
    publicIP = resource.oci_core_public_ip.blue.id
    SubnetId = oci_core_subnet.blue.id
  }

  shape_config {
    ocpus         = 1
    memory_in_gbs = 1
  }

  source_details {
    source_type             = "image"
    source_id               = data.oci_core_images.ubuntu_minimal.images[0].id
    boot_volume_vpus_per_gb = "10"
  }

  lifecycle {
    ignore_changes = [
      source_details,
    ]
  }
}
