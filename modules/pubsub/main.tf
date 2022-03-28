# Defining the project, region and google version to use when deploying the GCP resources
provider "google" {
  project = local.project_id
  region  = data.terraform_remote_state.base.outputs.location
}

locals {
  project_id = data.terraform_remote_state.base.outputs.project_id
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

resource "google_pubsub_topic" "pubsub_topic" {
  count                       = var.pubsub_topic_creation == true ? 1 : 0
  name                        = var.pubsub_topic_name
}

resource "time_sleep" "wait_15_seconds" {
  depends_on = [google_pubsub_topic.pubsub_topic]

  create_duration = "15s"
}

resource "google_pubsub_subscription" "pubsub_subscription" {
  depends_on                  = [time_sleep.wait_15_seconds]
  name                        = var.pubsub_subscription_name
  topic                       = length(google_pubsub_topic.pubsub_topic) > 0 ? google_pubsub_topic.pubsub_topic[0].name : var.pubsub_topic_name

  message_retention_duration = var.pubsub_subscription_message_retention
  retain_acked_messages      = var.pubsub_subscription_retain_acked_messages

  ack_deadline_seconds       = var.pubsub_subscription_ack_deadline_seconds

  enable_message_ordering    = false
}
