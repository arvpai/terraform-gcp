## 000base

This layer ensures a streamlined deployment of the relevant network components (VPC & Private Subnets) by using network_creation module. Additionally, this layer will also enable specified GCP API Services to ensure that certain related resources can be provisioned. 

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.53.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp_api_cloudbuild"></a> [gcp\_api\_cloudbuild](#module\_gcp\_api\_cloudbuild) | ../../modules/api_enable | n/a |
| <a name="module_gcp_api_resourcemanager"></a> [gcp\_api\_resourcemanager](#module\_gcp\_api\_resourcemanager) | ../../modules/api_enable | n/a |
| <a name="module_gcp_api_servicenetworking"></a> [gcp\_api\_servicenetworking](#module\_gcp\_api\_servicenetworking) | ../../modules/api_enable | n/a |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | ../../modules/network_creation | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="api_service"></a> [api\_service](#input\_api\_service) | The service to enable. | `string` | N/A | yes |
| <a name="input_auto_create_subnetworks"></a> [auto\_create\_subnetworks](#input\_auto\_create\_subnetworks) | When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources. | `bool` | `false` | no |
| <a name="input_cidr_range_1"></a> [cidr\_range\_1](#input\_cidr\_range\_1) | THE CIDR range from private-subnet-1 | `string` | `"10.10.10.0/24"` | no |
| <a name="input_delete_default_internet_gateway_routes"></a> [delete\_default\_internet\_gateway\_routes](#input\_delete\_default\_internet\_gateway\_routes) | If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted | `bool` | `false` | no |
| <a name="disable_on_destroy"></a> [disable\_on\_destroy](#input\_disable\_on\_destroy) | If true, disable the service when the terraform resource is destroyed. Defaults to true. May be useful in the event that a project is long-lived but the infrastructure running in that project changes frequently. | `bool` | `false` | no |
| <a name="disable_dependent_service"></a> [disable\_dependent\_service](#input\_disable\_dependent\_service) | If true, services that are enabled and which depend on this service should also be disabled when this service is destroyed. If false or unset, an error will be generated if any enabled services depend on this service when destroying it. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Location where VPC will be deployed | `string` | `"europe-west2"` | no |
| <a name="input_mtu"></a> [mtu](#input\_mtu) | The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically. | `number` | `0` | no |
| <a name="input_network_description"></a> [network\_description](#input\_network\_description) | An optional description of this resource. The resource must be recreated to modify this field. | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix used to generate the project resources | `string` | `"data-asset"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project where this VPC will be created | `string` | `"engineering-assets-319815"` | no |
| <a name="input_routing_mode"></a> [routing\_mode](#input\_routing\_mode) | The network routing mode (default 'GLOBAL') | `string` | `"GLOBAL"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gcp_api_cloudbuild"></a> [gcp\_api\_cloudbuild](#output\_gcp\_api\_cloudbuild) | The name of the cloudbuild API Service |
| <a name="output_gcp_api_resourcemanager"></a> [gcp\_api\_resourcemanager](#output\_gcp\_api\_resourcemanager) | The name of the resourcemanager API Service |
| <a name="output_gcp_api_servicenetworking"></a> [gcp\_api\_servicenetworking](#output\_gcp\_api\_servicenetworking) | The name of the servicenetworking API Service |
| <a name="output_location"></a> [location](#output\_location) | The name of the location/region |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | The name of the VPC being created |
| <a name="output_prefix"></a> [prefix](#output\_prefix) | The name of the prefix |
| <a name="output_private-subnets"></a> [private-subnets](#output\_private-subnets) | The name of the Subnet being created |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | The name of the Project |

## Enabling additional GCP API Services

To enable additional GCP API Services, simply duplicate the module block in `.terraform/layers/100base/api.tf` and replace the input values (Please refer to the `Inputs` table above).

Example:

```bash
module "gcp_api_servicenetworking" {
  project_id                 = var.project_id
  location                   = var.location
  source                     = "../../modules/api_enable"
  api_service                = "<replace>
  disable_on_destroy         = <replace>
  disable_dependent_services = <replace>
}
```

## Provisioning additional GCP Network Subnets

To provision additional GCP network subnets, simply duplicate the `subnets` parameter within the `vpc` module block in `.terraform/layers/100base/vpc.tf` and replace the input values (Please refer to the `Inputs` table above).

Example:

```bash
module "vpc" {
  source          = "../../modules/network_creation"
  project_id      = var.project_id
  network_name    = join("-", [local.prefix, "vpc"])
  shared_vpc_host = false

  subnets = [
    {
      subnet_name           = join("-", [local.prefix, "private-subnet-1"])
      subnet_ip             = "10.10.10.0/24"
      subnet_region         = var.location
      subnet_private_access = "true"
      subnet_flow_logs      = "true"
    }
    {
      subnet_name           = join("-", [local.prefix, "<replace>"])
      subnet_ip             = "<replace>"
      subnet_region         = var.location
      subnet_private_access = "<replace>"
      subnet_flow_logs      = "<replace>"
    }
  ]
}
```