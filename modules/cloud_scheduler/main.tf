data "terraform_remote_state" "base" {
  backend   = "gcs"
  workspace = terraform.workspace
  config = {
    bucket = "tfstate_file"
    prefix = "base"
  }
}



locals {
  project_id  = data.terraform_remote_state.base.outputs.project_id
  region      = data.terraform_remote_state.base.outputs.location
}

# Defining the project, region and google version to use when deploying the GCP resources
provider "google" {
  project = local.project_id
  region  = local.region
}

resource "google_cloud_scheduler_job" "pubsub_job" {
  count            = var.pubsub_scheduler_count
  name             = var.scheduler_name
  description      = var.scheduler_description
  schedule         = var.scheduler_schedule
  time_zone        = var.scheduler_time_zone
  attempt_deadline = var.scheduler_deadline

  retry_config {
    retry_count = var.scheduler_retries
  }

  pubsub_target {
    # topic.id is the topic's full resource name.
    topic_name = var.pubsub_target_topic
    data       = base64encode(var.scheduler_description)
  }
}

resource "google_cloud_scheduler_job" "http_job" {
  count            = var.http_scheduler_count
  name             = var.scheduler_name
  description      = var.scheduler_description
  schedule         = var.scheduler_schedule
  time_zone        = var.scheduler_time_zone
  attempt_deadline = var.scheduler_deadline

  retry_config {
    retry_count = var.scheduler_retries
  }

  http_target {
    http_method = "POST"
    uri         = var.scheduler_post_uri
    body        = base64encode(var.scheduler_description)
  }
}
