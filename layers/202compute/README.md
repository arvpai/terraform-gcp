## 200Compute ##
This layer deploys the functions decribed in the code. In order to add more functions the steps are:

- Create a folder under `./terraform/layers/200compute/functions/` for the function
- Add a .zip file with the code
- Replicate the module block with the parameters needed for the new function (check Cloud Functions repository cloud-functions/scripts)

If you modify a function do the following steps:

- zip the content of the folder into a main.zip file
- Move main.zip into `./terraform/layers/200compute/functions/function_name`
- Re-run `./tf.sh default apply -1`

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 3.53.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_function_batch"></a> [function\_batch](#module\_function\_batch) | ../../modules/function_creation | n/a |

## Resources

| Name | Type |
|------|------|
| [terraform_remote_state.base](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.data](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_function_description"></a> [function\_description](#input\_function\_description) | Description of the function | `string` | `""` | no |
| <a name="input_function_entrypoint"></a> [function\_entrypoint](#input\_function\_entrypoint) | Name of the function that will be executed when the Google Cloud Function is triggered | `string` | `"get_object_metadata"` | no |
| <a name="input_function_file_name"></a> [function\_file\_name](#input\_function\_file\_name) | Name of the file that contains the code to execute | `string` | `""` | no |
| <a name="input_function_file_path"></a> [function\_file\_path](#input\_function\_file\_path) | Path to the zip file which contains the code | `string` | `""` | no |
| <a name="input_function_memory"></a> [function\_memory](#input\_function\_memory) | Memory (in MB), available to the function | `number` | `256` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | A user-defined name of the function | `string` | `""` | no |
| <a name="input_function_role"></a> [function\_role](#input\_function\_role) | IAM role to invoke the functions | `string` | `"allUsers"` | no |
| <a name="input_function_runtime"></a> [function\_runtime](#input\_function\_runtime) | The runtime in which the function is going to run | `string` | `""` | no |
| <a name="input_function_timeout"></a> [function\_timeout](#input\_function\_timeout) | Timeout (in seconds) for the function | `number` | `60` | no |
| <a name="input_function_trigger_event_type"></a> [function\_trigger\_event\_type](#input\_function\_trigger\_event\_type) | A source that fires events in response to a condition in another service | `string` | `"google.storage.object.finalize"` | no |
| <a name="input_function_trigger_http"></a> [function\_trigger\_http](#input\_function\_trigger\_http) | Boolean variable. Any HTTP request (of a supported type) to the endpoint will trigger function execution | `bool` | `false` | no |

## Outputs

No outputs.
