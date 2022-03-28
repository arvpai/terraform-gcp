output "dataflow_trigger_topic" {
  #value = join("/", ["projects", data.terraform_remote_state.base.outputs.project_id, "topics", module.scheduler_dataflow_cloud_function_subscription.topic_name])
  value = module.scheduler_dataflow_cloud_function_subscription.topic_name
}

output "uk_properties_cloud_function_data_stream_topic" {
  #value = join("/", ["projects", data.terraform_remote_state.base.outputs.project_id, "topics", module.uk_properties_streaming_subscription.topic_name])
  value = module.uk_properties_streaming_subscription.topic_name
}

output "uk_properties_cloud_function_data_stream_subscription" {
  #value = join("/", ["projects", data.terraform_remote_state.base.outputs.project_id, "topics", module.uk_properties_streaming_subscription.topic_name])
  value = module.uk_properties_streaming_subscription.subscription_name
}

output "uk_properties_spark_streaming_topic" {
  #value = join("/", ["projects", data.terraform_remote_state.base.outputs.project_id, "topics", module.uk_properties_spark_streaming_subscription.topic_name])
  value = module.uk_properties_spark_streaming_subscription.topic_name
}

output "uk_properties_spark_streaming_subscription" {
  #value = join("/", ["projects", data.terraform_remote_state.base.outputs.project_id, "topics", module.uk_properties_spark_streaming_subscription.topic_name])
  value = module.uk_properties_spark_streaming_subscription.subscription_name
}

output "uk_properties_dataflow_data_stream_topic" {
  #value = join("/", ["projects", data.terraform_remote_state.base.outputs.project_id, "topics", module.uk_properties_dataflow_streaming_subscription.topic_name])
  value = module.uk_properties_dataflow_streaming_subscription.topic_name
}

output "uk_properties_dataflow_data_stream_subscription" {
  #value = join("/", ["projects", data.terraform_remote_state.base.outputs.project_id, "topics", module.uk_properties_dataflow_streaming_subscription.topic_name])
  value = module.uk_properties_dataflow_streaming_subscription.subscription_name
}
