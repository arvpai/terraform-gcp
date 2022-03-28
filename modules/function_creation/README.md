## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_cloudfunctions_function.function](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function) | resource |
| [google_cloudfunctions_function_iam_member.function_invoker](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions_function_iam_member) | resource |
| [google_storage_bucket_object.bucket_object](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_object) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | Bucket containing the function code | `string` | `""` | no |
| <a name="input_env_bucket_name"></a> [env\_bucket\_name](#input\_env\_bucket\_name) | Environmental variable for the function settign the bucket name | `string` | `""` | no |
| <a name="input_env_dataset_name"></a> [env\_dataset\_name](#input\_env\_dataset\_name) | Environmental variable for the function settign the dataset name | `string` | `""` | no |
| <a name="input_env_table_name"></a> [env\_table\_name](#input\_env\_table\_name) | Environmental variable for the function settign the table name | `string` | `""` | no |
| <a name="input_function_description"></a> [function\_description](#input\_function\_description) | Description of the function | `string` | `""` | no |
| <a name="input_function_entrypoint"></a> [function\_entrypoint](#input\_function\_entrypoint) | Name of the function that will be executed when the Google Cloud Function is triggered | `string` | `""` | no |
| <a name="input_function_file_name"></a> [function\_file\_name](#input\_function\_file\_name) | Name of the file that contains the code to execute | `string` | `""` | no |
| <a name="input_function_file_path"></a> [function\_file\_path](#input\_function\_file\_path) | Path to the zip file which contains the code | `string` | `""` | no |
| <a name="input_function_memory"></a> [function\_memory](#input\_function\_memory) | Memory (in MB), available to the function | `number` | `256` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | A user-defined name of the function | `string` | `""` | no |
| <a name="input_function_role"></a> [function\_role](#input\_function\_role) | IAM role to invoke the functions | `string` | `""` | no |
| <a name="input_function_runtime"></a> [function\_runtime](#input\_function\_runtime) | The runtime in which the function is going to run | `string` | `""` | no |
| <a name="input_function_timeout"></a> [function\_timeout](#input\_function\_timeout) | Timeout (in seconds) for the function | `number` | `60` | no |
| <a name="input_function_trigger_event_resource"></a> [function\_trigger\_event\_resource](#input\_function\_trigger\_event\_resource) | The name or partial URI of the resource from which to observe events | `string` | `""` | no |
| <a name="input_function_trigger_event_type"></a> [function\_trigger\_event\_type](#input\_function\_trigger\_event\_type) | A source that fires events in response to a condition in another service | `string` | `""` | no |
| <a name="input_function_trigger_http"></a> [function\_trigger\_http](#input\_function\_trigger\_http) | Boolean variable. Any HTTP request (of a supported type) to the endpoint will trigger function execution | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Resources location | `string` | `""` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Prefix used to generate the project resources | `string` | `""` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | GCP project id | `string` | `""` | no |

## Outputs

No outputs.
