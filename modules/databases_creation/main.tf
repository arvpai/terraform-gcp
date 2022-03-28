# Defining the project, region and google version to use when deploying the GCP resources
provider "google" {
  project = data.terraform_remote_state.base.outputs.project_id
  region  = data.terraform_remote_state.base.outputs.location
}

# Data block to retrieve output data from the base layer terraform statefile to be used in the resource block
data "terraform_remote_state" "base" {
  backend   = "gcs"
  workspace = terraform.workspace
  config = {
    bucket = "tfstate_file"
    prefix = "base"
  }
}

# Create local variable `prefix` and use the local variable in the resource block
locals {
  prefix = "${data.terraform_remote_state.base.outputs.prefix}" == "" ? "" : join("-", ["${data.terraform_remote_state.base.outputs.prefix}", lower("${data.terraform_remote_state.base.outputs.location}"), ""])
}

resource "google_sql_database_instance" "mysql_instance" {
  name             = "${var.db_name}"
  database_version = "${var.db_version}"

  settings{
    tier = "${var.db_tier}"
    activation_policy = "${var.db_activation_policy}"
    disk_autoresize = "${var.db_disk_autoresize}"
    disk_size = "${var.db_disk_size}"
    disk_type = "${var.db_disk_type}"
    pricing_plan = "${var.db_pricing_plan}"

    ip_configuration {
      ipv4_enabled    = false
      private_network = "projects/${data.terraform_remote_state.base.outputs.project_id}/global/networks/${data.terraform_remote_state.base.outputs.network_name}"
    }

  }

}

resource "google_sql_user" "users" {
  name     = var.db_username
  instance = google_sql_database_instance.mysql_instance.name
  password = var.db_password
}
