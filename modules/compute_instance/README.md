## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_compute_instance.instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance) | resource |
| [google_service_account.instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [random_string.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_boot_image"></a> [boot\_image](#input\_boot\_image) | The image to be used to create boot volume. | `string` | n/a | yes |
| <a name="input_boot_size"></a> [boot\_size](#input\_boot\_size) | The size in GB for the boot volume. | `number` | n/a | yes |
| <a name="input_boot_type"></a> [boot\_type](#input\_boot\_type) | The type of the boot volume, defaults to pb-balanced. | `string` | `"pd-balanced"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name of the instance. | `string` | `""` | no |
| <a name="input_machine_type"></a> [machine\_type](#input\_machine\_type) | The type of the instance, defaults to e2-small. | `string` | `"e2-small"` | no |
| <a name="input_network"></a> [network](#input\_network) | The network to launch the instance in. | `string` | n/a | yes |
| <a name="input_startup_script"></a> [startup\_script](#input\_startup\_script) | The startup script for instance bootstrapping. | `string` | `""` | no |
| <a name="input_subnetwork"></a> [subnetwork](#input\_subnetwork) | The subnetwork to launch this instance in. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | A list of tags to be applied to this instance. | `list(string)` | `[]` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | The zone to launch this instance in. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all"></a> [all](#output\_all) | All outputs from google\_compute\_instance resource, see terraform / gcp provider documentation for more information. |
| <a name="output_id"></a> [id](#output\_id) | The id of GCP Compute Instance created by this module. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The self\_link of GCP Compute Instance created by this module. |
