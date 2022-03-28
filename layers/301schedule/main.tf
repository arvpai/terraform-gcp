terraform {
  backend "gcs" {
    bucket = "tfstate_file"
    prefix = "schedule"
  }
}

data "terraform_remote_state" "pubsub" {
  backend   = "gcs"
  workspace = terraform.workspace
  config = {
    bucket = "tfstate_file"
    prefix = "pubsub"
  }
}

module "streaming_dataflow_job_trigger" {
  source                    = "../../modules/cloud_scheduler"
  pubsub_scheduler_count    = 1
  scheduler_name            = "Streaming-Dataflow-Job-Trigger"
  scheduler_schedule        = "0 15 * * *"
  pubsub_target_topic       = data.terraform_remote_state.pubsub.outputs.dataflow_trigger_topic
}
