provider "docker" {
  # TODO
  # host     = "ssh://ubuntu@${oci_core_instance.blue.public_ip}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}

resource "docker_image" "hello_world" {
  name = "hello-world"
}
