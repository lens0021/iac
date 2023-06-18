terraform {
  required_version = "~> 1.0"

  backend "remote" {
    organization = "lens0021"

    workspaces {
      name = "docker-oci"
    }
  }

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0"
    }
  }
}

provider "docker" {
  # TODO
  # host     = "ssh://ubuntu@${oci_core_instance.blue.public_ip}:22"
  ssh_opts = ["-o", "StrictHostKeyChecking=no", "-o", "UserKnownHostsFile=/dev/null"]
}
