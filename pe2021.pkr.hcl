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
  # What is the purpose of the image_family? Is it just a tag?
  image_family        = "pe2021"
  source_image_family = "rocky-linux-8"
  # Set ssh_username to the username you use to connect to your instance. Can it be root? And then create a user in the bootstrap script?
  ssh_username        = "root"
  zone                = "us-west1-b"
}

build {
  sources = ["source.googlecompute.cd4pe5"]

  provisioner "file" {
    destination = "/tmp/resources"
    source      = "./resources"
  }

  provisioner "shell" {
    execute_command  = "echo 'root' | {{ .Vars }} sudo -E -S bash '{{ .Path }}'"
    script           = "./bootstrap_scripts/bootstrap.sh"
    valid_exit_codes = [0, 2, 4, 6]
  }

}