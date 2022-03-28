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

resource "google_bigquery_dataset" "dataset" {
  count               = (var.create_dataset == true) ? 1 : 0
  dataset_id          = var.bigquery_dataset_name
  description         = var.bigquery_dataset_description

  access {
    role              = "OWNER"
    group_by_email    = "grp.gcp.data.engineers@gftdevgcp.com"
  }
}

resource "time_sleep" "wait_15_seconds" {
  depends_on = [google_bigquery_dataset.dataset]

  create_duration = "15s"
}

resource "google_bigquery_table" "table" {
  depends_on          = [time_sleep.wait_15_seconds]
  dataset_id          = length(google_bigquery_dataset.dataset) > 0 ? google_bigquery_dataset.dataset[0].dataset_id : var.bigquery_dataset_name
  table_id            = var.bigquery_table_name

  schema              = file("../../layers/101databases/tables_schemas/${var.bigquery_table_name}.json")
}
