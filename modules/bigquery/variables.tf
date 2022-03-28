variable "bigquery_dataset_name" {
  description = "BigQuery Dataset where tables will be created"
  default     = ""
}

variable "bigquery_dataset_description" {
  description = "BigQuery Datsetbrief Description"
}

variable "bigquery_table_name" {
  description = "BigQuery Table linked to a Dataset"
  default     = ""
}

variable "create_dataset" {
  description = "true if required to create the Dataset in BigQuery"
  type = bool
  default = false
}
