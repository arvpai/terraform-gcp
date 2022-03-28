locals {
  bucket_name = split("/", var.bucket_name)[0]
  directory_name = split("/", var.bucket_name)[1]
}

## Function executable upload ##
resource "google_storage_bucket_object" "bucket_object" {
  name   = join("/", [local.directory_name, "main.zip"])
  bucket = local.bucket_name
  source = join("/", [var.function_file_path, var.function_file_name])
}

## Function creation ##
resource "google_cloudfunctions_function" "function" {
  name        = join("-",[var.prefix, lower(var.function_name)])
  description = var.function_description
  runtime     = var.function_runtime

  available_memory_mb   = var.function_memory
  source_archive_bucket = local.bucket_name
  source_archive_object = google_storage_bucket_object.bucket_object.name

  event_trigger {
    event_type = var.function_trigger_event_type
    resource   = var.function_trigger_event_resource
  }

  timeout     = var.function_timeout
  entry_point = var.function_entrypoint
  labels = {
    managed_by = "terraform"
  }

  environment_variables = var.env_variables

}

# IAM entry for a single user to invoke the function
resource "google_cloudfunctions_function_iam_member" "function_invoker" {
  project        = var.project_id
  region         = var.location
  cloud_function = google_cloudfunctions_function.function.name
  role           = "roles/cloudfunctions.invoker"
  member         = var.function_role
}
