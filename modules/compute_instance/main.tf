data "terraform_remote_state" "base" {
  backend   = "gcs"
  workspace = terraform.workspace
  config = {
    bucket = "tfstate_file"
    prefix = "base"
  }
}

resource "google_compute_instance" "instance" {
  project      = data.terraform_remote_state.base.outputs.project_id
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  # network tags
  tags = var.tags

  # boot volume configuration
  boot_disk {
    initialize_params {
      image = var.boot_image
      size  = var.boot_size
      type  = var.boot_type
    }
  }

  network_interface {
    network    = var.network
  }

  # startup script for instance bootstrapping
  metadata_startup_script = var.startup_script

  service_account {
    email  = var.service_account
    scopes = ["cloud-platform"]
  }
}
