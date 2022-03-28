terraform {
  backend "gcs" {
    bucket = "tfstate_file"
    prefix = "pubsub"
  }
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

module "uk_properties_streaming_subscription" {
  source                    = "../../modules/pubsub"
  pubsub_topic_name         = "uk_properties_cloud_function_data_stream"
  pubsub_topic_creation     = true
  pubsub_subscription_name  = "uk_properties_streaming"
}

module "uk_properties_spark_streaming_subscription" {
  source                    = "../../modules/pubsub"
  pubsub_topic_name         = "uk_properties_spark_data_stream"
  pubsub_topic_creation     = true
  pubsub_subscription_name  = "uk_properties_spark_streaming"
}

module "uk_properties_dataflow_streaming_subscription" {
  source                    = "../../modules/pubsub"
  pubsub_topic_name         = "uk_properties_dataflow_data_stream"
  pubsub_topic_creation     = true
  pubsub_subscription_name  = "uk_properties_dataflow_data_stream"
}

module "scheduler_dataflow_cloud_function_subscription" {
  source                    = "../../modules/pubsub"
  pubsub_topic_name         = "scheduler_dataflow_cloud_function"
  pubsub_topic_creation     = true
  pubsub_subscription_name  = "scheduler_dataflow_cloud_function_sub"
}
