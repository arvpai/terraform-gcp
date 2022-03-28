terraform {
  backend "gcs" {
    bucket = "tfstate_file"
    prefix = "databases"
  }
}

module "gcp_cloud_sql_hive_metastore" {
  source = "../../modules/databases_creation"
  db_name = "db-hive-metastore"
  db_username = "root"
}

module "gcp_cloud_uk_properties_bigquery_table" {
  source                        = "../../modules/bigquery"
  bigquery_dataset_name         = "landing_zone"
  bigquery_table_name           = "uk_properties_batch_spark"
  bigquery_dataset_description  = "Bigquery Dataset including UK Properties tables generated on different processes"
}

module "gcp_cloud_streaming_uk_properties_bigquery_table" {
  source                        = "../../modules/bigquery"
  bigquery_dataset_name         = "landing_zone"
  bigquery_table_name           = "uk_properties_streaming_spark"
  bigquery_dataset_description  = "Bigquery Dataset including UK Properties tables generated on different processes"
}

module "gcp_cloud_housing_raw_batch_bigquery_table" {
  source                        = "../../modules/bigquery"
  bigquery_dataset_name         = "landing_zone"
  bigquery_table_name           = "uk_properties_batch_validated"
  bigquery_dataset_description  = "Bigquery Dataset including UK Properties tables generated on different processes - updated with validation"
}

module "gcp_cloud_housing_raw_streaming_bigquery_table" {
  source                        = "../../modules/bigquery"
  bigquery_dataset_name         = "landing_zone"
  bigquery_table_name           = "uk_properties_streaming"
  bigquery_dataset_description  = "Bigquery Dataset including UK Properties tables generated on different processes"
}

module "gcp_cloud_dataflow_streaming_bigquery_table" {
  source                        = "../../modules/bigquery"
  bigquery_dataset_name         = "landing_zone"
  bigquery_table_name           = "uk_properties_streaming_dataflow"
  bigquery_dataset_description  = "Bigquery Dataset including UK Properties tables generated on different processes"
}
