# Autogenerate and store terraform state file in GCP Cloud storage bucket 'tfstate_file'
terraform {
  backend "gcs" {
    bucket = "tfstate_file"
    prefix = "base"
  }
}

locals {
  prefix = var.prefix == "" ? "" : join("-", [var.prefix, lower(var.location)])
}


/******************************************
	VPC configuration & Private Subnets
 *****************************************/

module "vpc" {
  source          = "../../modules/network_creation"
  project_id      = var.project_id
  network_name    = join("-", ["vpc", local.prefix])
  shared_vpc_host = false

  subnets = [
    {
      subnet_name           = join("-", [local.prefix, "private-subnet-1"])
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = var.location
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    }
  ]

  private_ip_name  = "privatevpcip"
}
