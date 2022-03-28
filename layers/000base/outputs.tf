output "project_id" {
  value       = var.project_id
  description = "The name of the Project"
}

output "prefix" {
  value       = var.prefix
  description = "The name of the prefix"
}

output "location" {
  value       = var.location
  description = "The name of the location/region"
}

output "network_name" {
  value       = module.vpc.network_name
  description = "The name of the VPC being created"
}

output "private-subnets" {
  value       = join("-", [local.prefix, "private-subnet-1"])
  description = "The name of the Subnet being created"
}

# To output GCP API Service information to terminal

output "gcp_api_cloudbuild" {
  value = module.gcp_api_cloudbuild.gcp_api_service
}

output "gcp_api_servicenetworking" {
  value = module.gcp_api_servicenetworking.gcp_api_service
}

output "gcp_api_resourcemanager" {
  value = module.gcp_api_resourcemanager.gcp_api_service
}