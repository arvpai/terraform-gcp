## 100data

This layer will deploy a list of GCP Cloud Storage buckets.

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gcp_cloud_storage_batch"></a> [gcp\_cloud\_storage\_batch](#module\_gcp\_cloud\_storage\_batch) | ../../modules/storage_creation | n/a |
| <a name="module_gcp_cloud_storage_datalake"></a> [gcp\_cloud\_storage\_datalake](#module\_gcp\_cloud\_storage\_datalake) | ../../modules/storage_creation | n/a |
| <a name="module_gcp_cloud_storage_function"></a> [gcp\_cloud\_storage\_function](#module\_gcp\_cloud\_storage\_function) | ../../modules/storage_creation | n/a |

## Resources

No resources.

## Inputs


| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="bucket_name"></a> [bucket\_name](#input\_bucket\_name) | The name of the bucket. | `string` | N/A | yes |
| <a name="storage_class"></a> [storage\_class](#input\_storage\_class) | The Storage Class of the new bucket. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE. | `string` | "STANDARD" | no |
| <a name="uniform_bucket_level_access"></a> [uniform\_bucket\_level\_access](#input\_uniform\_bucket\_level\_access) | Enables Uniform bucket-level access access to a bucket. | `bool` | false | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_batch_bucket"></a> [batch\_bucket](#output\_batch\_bucket) | The name of the Batch bucket |
| <a name="output_datalake_bucket"></a> [datalake\_bucket](#output\_datalake\_bucket) | The name of the Datalake bucket |
| <a name="output_function_bucket"></a> [function\_bucket](#output\_function\_bucket) | The name of the Functions bucket |
| <a name="output_jars_bucket"></a> [jars\_bucket](#output\_jars\_bucket) | The name of the Jars bucket |

## Provisioning additional GCP Cloud Storage instances

To deploy additional GCP cloud storage instances, simply duplicate the module block in `.terraform/layers/100data/main.tf` and replace the input values (Please refer to the `Inputs` table above).

```bash
module "gcp_cloud_storage_function" {
    source = "../../modules/storage_creation"
    bucket_name = "<replace>"
    storage_class = "<replace>"
    uniform_bucket_level_access = "<replace>"
}
```
