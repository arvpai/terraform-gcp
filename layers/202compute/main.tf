### general settings for terraform ###
terraform {
  backend "gcs" {
    bucket = "tfstate_file"
    prefix = "compute"
  }
}

provider "google" {
  project = data.terraform_remote_state.base.outputs.project_id
  region  = data.terraform_remote_state.base.outputs.location
}

## loading the terraform state from the other layers ##
## in case there is a need to reference outputs      ##
data "terraform_remote_state" "base" {
  backend = "gcs"

  config = {
    bucket = "tfstate_file"
    prefix = "base"
  }
}

data "terraform_remote_state" "data" {
  backend = "gcs"

  config = {
    bucket = "tfstate_file"
    prefix = "data"
  }
}

data "terraform_remote_state" "databases" {
  backend = "gcs"

  config = {
    bucket = "tfstate_file"
    prefix = "databases"
  }
}

data "terraform_remote_state" "pubsub" {
  backend = "gcs"

  config = {
    bucket = "tfstate_file"
    prefix = "pubsub"
  }
}

### Batch Function Creation Begin ###
module "function_batch" {
  source     = "../../modules/function_creation"
  project_id = data.terraform_remote_state.base.outputs.project_id
  location   = data.terraform_remote_state.base.outputs.location
  prefix     = data.terraform_remote_state.base.outputs.prefix

  # bucket object #
  function_file_name = "batch_etl.zip"
  bucket_name        = data.terraform_remote_state.data.outputs.batch_function_bucket
  function_file_path = "./functions/batch"
  # bucket object #

  # function creation #
  function_name        = "function-batch"
  function_description = "Function that reads data generated into a specified bucket"
  function_runtime     = "python37"
  function_memory      = 512
  # function_trigger_http = "" # to-do #
  function_trigger_event_type     = "google.storage.object.finalize"
  function_trigger_event_resource = data.terraform_remote_state.data.outputs.batch_bucket
  function_timeout                = 60
  function_entrypoint             = "batch_load_csv_to_bq"
  # environmental variables #
  env_variables = {
    "PROJECT"             = data.terraform_remote_state.base.outputs.project_id
    "BUCKET"              = data.terraform_remote_state.data.outputs.batch_bucket
    "VALIDATION_BUCKET"   = data.terraform_remote_state.data.outputs.batch_validation_bucket
    "DATASET"             = data.terraform_remote_state.databases.outputs.housing_raw_batch_dataset
    "TABLE"               = data.terraform_remote_state.databases.outputs.housing_raw_batch
  }
  # function creation #

  # IAM creation #
  function_role = "allUsers"
  # IAM creation #

}

module "function_streaming" {
  source     = "../../modules/function_creation"
  project_id = data.terraform_remote_state.base.outputs.project_id
  location   = data.terraform_remote_state.base.outputs.location
  prefix     = data.terraform_remote_state.base.outputs.prefix

  # bucket object #
  function_file_name = "streaming_etl.zip"
  bucket_name        = data.terraform_remote_state.data.outputs.streaming_function_bucket
  function_file_path = "./functions/streaming"
  # bucket object #

  # function creation #
  function_name        = "function-streaming"
  function_description = "Function that reads data generated from PubSub into a specified bucket"
  function_runtime     = "python37"
  function_memory      = 256
  # function_trigger_http = "" # to-do #
  function_trigger_event_type     = "google.pubsub.topic.publish"
  function_trigger_event_resource = data.terraform_remote_state.pubsub.outputs.uk_properties_cloud_function_data_stream_topic
  function_timeout                = 60
  function_entrypoint             = "pubsub_to_bigq"
  # function creation #

  env_variables = {
    "project_id"      = data.terraform_remote_state.base.outputs.project_id
    "subscription_id" = data.terraform_remote_state.pubsub.outputs.uk_properties_cloud_function_data_stream_subscription
    "dataset"         = data.terraform_remote_state.databases.outputs.housing_raw_streaming_dataset
    "table"           = data.terraform_remote_state.databases.outputs.housing_raw_streaming
  }

  # IAM creation #
  function_role = "allUsers"
  # IAM creation #

}

module "function_dataflow_streaming" {
  source     = "../../modules/function_creation"
  project_id = data.terraform_remote_state.base.outputs.project_id
  location   = data.terraform_remote_state.base.outputs.location
  prefix     = data.terraform_remote_state.base.outputs.prefix

  # bucket object #
  function_file_name = "streaming_dataflow_etl.zip"
  bucket_name        = data.terraform_remote_state.data.outputs.dataflow_streaming_function_bucket
  function_file_path = "./functions/dataflow"
  # bucket object #

  # function creation #
  function_name        = "function-dataflow-streaming"
  function_description = "Function that reads data generated from PubSub into a specified bucket"
  function_runtime     = "python37"
  function_memory      = 4096
  # function_trigger_http = "" # to-do #
  function_trigger_event_type     = "google.pubsub.topic.publish"
  function_trigger_event_resource = data.terraform_remote_state.pubsub.outputs.dataflow_trigger_topic
  function_timeout                = 60
  function_entrypoint             = "trigger_streaming_pipeline"
  # function creation #

  env_variables = {
    "project_id"        = data.terraform_remote_state.base.outputs.project_id
    "project_region"    = data.terraform_remote_state.base.outputs.location
    "bucket_name"       = data.terraform_remote_state.data.outputs.dataflow_streaming_function_bucket
    "topic_id"          = data.terraform_remote_state.pubsub.outputs.uk_properties_dataflow_data_stream_topic
    "bigquery_dataset"  = data.terraform_remote_state.databases.outputs.properties_data_stream_dataset
    "bigquery_table"    = data.terraform_remote_state.databases.outputs.properties_data_stream
    "process_name"      = "streaming-properties"
  }

  # IAM creation #
  function_role = "allUsers"
  # IAM creation #

}
