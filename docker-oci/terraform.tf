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
