output "uk_properties_batch_spark"{
  value = module.gcp_cloud_uk_properties_bigquery_table.table_id
}

output "uk_properties_batch_spark_dataset"{
  value = module.gcp_cloud_uk_properties_bigquery_table.dataset_id
}

output "uk_properties_streaming_spark"{
  value = module.gcp_cloud_streaming_uk_properties_bigquery_table.table_id
}

output "uk_properties_streaming_spark_dataset"{
  value = module.gcp_cloud_streaming_uk_properties_bigquery_table.dataset_id
}

output "housing_raw_batch"{
  value = module.gcp_cloud_housing_raw_batch_bigquery_table.table_id
}

output "housing_raw_batch_dataset"{
  value = module.gcp_cloud_housing_raw_batch_bigquery_table.dataset_id
}

output "housing_raw_streaming"{
  value = module.gcp_cloud_housing_raw_streaming_bigquery_table.table_id
}

output "housing_raw_streaming_dataset"{
  value = module.gcp_cloud_housing_raw_streaming_bigquery_table.dataset_id
}

output "properties_data_stream"{
  value = module.gcp_cloud_dataflow_streaming_bigquery_table.table_id
}

output "properties_data_stream_dataset"{
  value = module.gcp_cloud_dataflow_streaming_bigquery_table.dataset_id
}
