packer {
  required_plugins {
    googlecompute = {
      source  = "github.com/hashicorp/googlecompute"
      version = "~> 1"
    }
  }
}

locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

source "googlecompute" "pe2021" {
  image_labels = {
    created = "${local.timestamp}"
  }
  image_name          = "pe2021-${local.timestamp}"
  instance_name       = "pe2021-${local.timestamp}"
  machine_type        = "e2-standard-8"
  project_id          = "kmo-instruqt"
  image_family        = "pe2021"
  source_image_family = "rocky-linux-8-optimized-gcp"
  ssh_username        = "peinstaller"
  zone                = "us-west1-b"
}

build {
  sources = ["source.googlecompute.pe2021"]

  provisioner "file" {
    destination = "/tmp/resources"
    source      = "./resources"
  }

  provisioner "shell" {
    execute_command  = "echo 'peinstaller' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    script           = "./bootstrap_scripts/bootstrap.sh"
    valid_exit_codes = [0, 2, 4, 6]
  }

}