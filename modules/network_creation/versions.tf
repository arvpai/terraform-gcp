terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.53.0"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-network:vpc/v3.3.0"
  }
}
