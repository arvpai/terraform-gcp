## Enable API Module

This directory contains resource blocks that'll enable the the 000base layer to enable specified GCP API Services.
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.53.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 3.53.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_service.gcp-api-services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_service"></a> [api\_service](#input\_api\_service) | GCP API services to enable | `string` | `""` | no |
| <a name="input_disable_dependent_services"></a> [disable\_dependent\_services](#input\_disable\_dependent\_services) | If true, services that are enabled and which depend on this service should also be disabled when this service is destroyed. | `bool` | `true` | no |
| <a name="input_disable_on_destroy"></a> [disable\_on\_destroy](#input\_disable\_on\_destroy) | If true, disable the service when the terraform resource is destroyed. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | Location where VPC will be deployed | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix used to generate the project resources | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_api_service"></a> [gcp\_api\_service](#output\_gcp\_api\_service) | n/a |
