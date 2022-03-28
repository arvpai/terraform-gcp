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

# Create GCP Cloud Storage resource
resource "google_storage_bucket" "storage" {
  name                        = "${local.prefix}${var.bucket_name}"
  project                     = data.terraform_remote_state.base.outputs.project_id
  location                    = data.terraform_remote_state.base.outputs.location
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.uniform_bucket_level_access
  labels = {
    managed_by = "terraform"
  }
}

resource "google_storage_bucket_object" "objects" {
  for_each  = var.object_names

  name      = each.value.object_name
  source    = each.value.object_source
  bucket    = google_storage_bucket.storage.name
}

resource "google_storage_bucket_object" "bucket_folders" {
  count = "${length(var.directory_names)}"
  name = "${element(var.directory_names, count.index)}"
  content = "${element(var.directory_names, count.index)}"
  bucket = google_storage_bucket.storage.name
}
