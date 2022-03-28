# Autogenerate and store terraform state file in GCP Cloud storage bucket 'tfstate_file'
terraform {
  backend "gcs" {
    bucket = "tfstate_file"
    prefix = "data"
  }
}

module "gcp_cloud_storage_function" {
    source = "../../modules/storage_creation"
    bucket_name = "function"
    storage_class = "STANDARD"
    uniform_bucket_level_access = true
    directory_names=["batch_cloud_function/","streaming_cloud_function/", "dataflow_streaming_cloud_function/"]
}

module "gcp_cloud_storage_batch" {
    source = "../../modules/storage_creation"
    bucket_name = "batch"
    storage_class = "STANDARD"
    uniform_bucket_level_access = true
    directory_names=["uk_properties/"]
}

module "gcp_cloud_storage_datalake" {
    source = "../../modules/storage_creation"
    bucket_name = "datalake"
    storage_class = "STANDARD"
    uniform_bucket_level_access = true
}

module "gcp_cloud_storage_jars" {
    source = "../../modules/storage_creation"
    bucket_name = "jars"
    storage_class = "STANDARD"
    uniform_bucket_level_access = true
}

module "gcp_cloud_storage_scripts" {
    source = "../../modules/storage_creation"
    bucket_name = "scripts"
    storage_class = "STANDARD"
    uniform_bucket_level_access = true

    object_names = {
      "addHiveTablesToDatalake" = {
        object_name: "dataproc_cluster_scripts/addHiveTablesToDatalake.sh"
        object_source: "./cluster_scripts/addHiveTablesToDatalake.sh"
      },
      "createCluster" = {
        object_name: "dataproc_cluster_scripts/createCluster.sh"
        object_source: "./cluster_scripts/createCluster.sh"
      },
      "removeCluster" = {
        object_name: "dataproc_cluster_scripts/removeCluster.sh"
        object_source: "./cluster_scripts/removeCluster.sh"
      },
      "triggerDataprocJob" = {
        object_name: "dataproc_cluster_scripts/triggerDataprocJob.sh"
        object_source: "./cluster_scripts/triggerDataprocJob.sh"
      }
    }
}

module "gcp_cloud_storage_batch_validation" {
    source = "../../modules/storage_creation"
    bucket_name = "batch-validation"
    storage_class = "STANDARD"
    uniform_bucket_level_access = true

    directory_names=["data_docs/expectations/"]
    object_names = {
      "uk_properties_batch_validated" = {
        object_name: "data_docs/expectations/uk_properties_batch_validated.json"
        object_source: "./batch_validation/uk_properties_batch_validated.json"
      }
    }
}

output "batch_bucket" {
  value = module.gcp_cloud_storage_batch.bucket_name
}

output "batch_validation_bucket" {
  value = module.gcp_cloud_storage_batch_validation.bucket_name
}

output "batch_function_bucket" {
  value = join("/", [module.gcp_cloud_storage_function.bucket_name, "batch_cloud_function"])
}

output "streaming_function_bucket" {
  value = join("/", [module.gcp_cloud_storage_function.bucket_name, "streaming_cloud_function"])
}

output "dataflow_streaming_function_bucket" {
  value = join("/", [module.gcp_cloud_storage_function.bucket_name, "dataflow_streaming_cloud_function"])
}

output "datalake_bucket" {
  value = module.gcp_cloud_storage_datalake.bucket_name
}

output "jars_bucket" {
  value = module.gcp_cloud_storage_jars.bucket_name
}
