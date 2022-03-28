# Module blocks below enables GCP API Services
module "gcp_api_cloudbuild" {
  project_id                 = var.project_id
  location                   = var.location
  source                     = "../../modules/api_enable"
  api_service                = "cloudbuild.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}

module "gcp_api_servicenetworking" {
  project_id                 = var.project_id
  location                   = var.location
  source                     = "../../modules/api_enable"
  api_service                = "servicenetworking.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}

module "gcp_api_resourcemanager" {
  project_id                 = var.project_id
  location                   = var.location
  source                     = "../../modules/api_enable"
  api_service                = "cloudresourcemanager.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}

module "gcp_api_cloudrun" {
  project_id                 = var.project_id
  location                   = var.location
  source                     = "../../modules/api_enable"
  api_service                = "run.googleapis.com"
  disable_on_destroy         = false
  disable_dependent_services = false
}
