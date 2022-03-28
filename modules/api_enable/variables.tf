variable "api_service" {
  description = "GCP API services to enable"
  type        = string
  default     = ""
}

variable "disable_on_destroy" {
  description = "If true, disable the service when the terraform resource is destroyed."
  type        = bool
  default     = true
}

variable "disable_dependent_services" {
  description = "If true, services that are enabled and which depend on this service should also be disabled when this service is destroyed."
  type        = bool
  default     = true
}

variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
  default     = ""
}

variable "prefix" {
  description = "Prefix used to generate the project resources"
  default     = ""
}

variable "location" {
  type        = string
  description = "Location where VPC will be deployed"
  default     = ""
}
