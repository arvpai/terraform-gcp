# Defining the project, region and google version to use when deploying the GCP resources
provider "google" {
  project = var.project_id
  region  = var.location
}

# Enables GCP API Services
resource "google_project_service" "gcp-api-services" {

  project = var.project_id
  service = var.api_service

  disable_on_destroy         = var.disable_on_destroy
  disable_dependent_services = var.disable_dependent_services
}
