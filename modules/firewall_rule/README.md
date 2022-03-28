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
| [google_compute_firewall.rule](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall) | resource |
| [random_string.id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_ports"></a> [allow\_ports](#input\_allow\_ports) | List of ports to be allowed. | `list(string)` | n/a | yes |
| <a name="input_allow_protocol"></a> [allow\_protocol](#input\_allow\_protocol) | Protocol to be allowed. | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | Name of the network this rule is to be applied to. | `string` | n/a | yes |
| <a name="input_rule_name"></a> [rule\_name](#input\_rule\_name) | Name of the firewall rule | `string` | n/a | yes |
| <a name="input_target_tags"></a> [target\_tags](#input\_target\_tags) | List of tags this firewall rule to be applied to. | `list(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_all"></a> [all](#output\_all) | All outputs from google\_compute\_firewall resource, see terraform / gcp provider documentation for more information. |
| <a name="output_id"></a> [id](#output\_id) | The id of firewall rule created by this module. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | The self\_link of firewall rule created by this module. |
