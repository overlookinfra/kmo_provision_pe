packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "googlecompute" "cd4pe5" {
  image_labels = {
    created = "${local.timestamp}"
  }
  image_name          = "cd4pe5-${local.timestamp}"
  instance_name       = "cd4pe5-${local.timestamp}"
  machine_type        = "e2-standard-8"
  project_id          = "kmo-instruqt"
  image_family        = "cd4pe5"
  source_image_family = "ubuntu-2004-lts"
  ssh_username        = "ubuntu"
  zone                = "us-west1-b"
}

build {
  sources = ["source.googlecompute.cd4pe5"]

  provisioner "file" {
    destination = "/tmp/resources"
    source      = "./resources"
  }

  provisioner "shell" {
    execute_command  = "echo 'ubuntu' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    script           = "./bootstrap_scripts/bootstrap.sh"
    valid_exit_codes = [0, 2, 4, 6]
  }

}