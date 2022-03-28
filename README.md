# Terraform

All the Terraform code for the GCP Data Engineering Asset should be stored in this repo

## Pre-requisite

1. Access to a GCP account, ideally with __gcloud command-line tool__ installed on your terminal.
2. Terraform v1.0.0 or above


## Deployment Note
The following section describes the workflow to deploy GCP resources using the `tf.sh` wrapper script provided.

### Syntax
The `tf.sh` script is a wrapper that takes in the following arguments, and performs terraform action automatically against all directories found under ./layers.

`./tf.sh [workspace] [action] [depth(integer)]`
* `workspace` (required) - the name of terraform workspace to use, default is `default`
* `action` (required) - can be one of the following: `init`, `plan`, `apply`, `destroy`
* `depth` (required) - the number of layers to perform terraform action against, specify `-1` to run against all directories under ./layers

### Working with workspaces

Terraform Workspace allows multiple copies of the same infrastructure to be deployed from the same code, even with the same backend configuration.
The default workspace that Terraform uses is `default`.

## Deployment Workflow

### Clone the repository
```bash
git clone git@git.gft.com:gcp-data-engineer-asset/terraform.git
cd terraform
```
###  Terraform Initialisation
```bash
./tf.sh default init -1
```
* `./tf.sh` - calls the wrapper script
* `default` - uses the "default" workspace
* `init` - performs the "init" action
* `-1` - against all directories found within "./layers" directory

### Terraform Apply
```bash
./tf.sh default apply -1
```
### Terraform Destroy
```bash
./tf.sh default destroy -1
```
This action destroys all resources created by Terraform, use with great caution!

## Advanced deployment option example
### Selective Terraform action
The following command performs Terraform plan to the first two directories found in ./layers directory, in alphanumeric order.
Action is performed under `dev` workspace.
```bash
./tf.sh dev plan 2
```
### Automatically approve Terraform actions (silent apply)
```bash
./tf.sh default apply -1 -auto-approve
```

## Sharing variables and outputs across layers

### Prerequisites
Resources being depended on must be created in a layer directory that comes first (alphanumerically).

Output will need to be added to `output.tf` in previous layers, and subsequent layers must specify "terraform_remote_state" data source.

#### Example
In `layers/000base/main.tf`:
```
terraform {
  backend "gcs" {
    bucket = "tfstate_file"
    prefix = "base"
  }
}
```

In `layers/210compute/main.tf`:
```
data "terraform_remote_state" "networking" {
  backend   = "gcs"
  workspace = terraform.workspace
  config = {
    bucket = "tfstate_file"
    prefix = "base"
  }
}
```

Layer `210compute` can now access outputs from `000base` layer.
```
module "firewall_allow_ssh" {
  ...
  network_name   = data.terraform_remote_state.networking.outputs.network_name
  ...
}
```

### To share common variables across layers (e.g., tags)

#### Example
##### Defining and outputting variables in upper layers
In `layers/000base/variables.tf`:
```
variable "location" {
  description = "Region where VPC will be deployed"
  type        = string
  default     = "europe-west2"
}
```

In `layers/000base/output.tf`:
```
output "location" {
  value       = var.location
  description = "The name of the location/region"
}
```

#### Importing variables to subsequent layers
In `layers/210compute/main.tf`:
```
locals {
  location   = data.terraform_remote_state.networking.outputs.location
}
```
`Note that reassigning variable to locals is optional, but it improves code readability further down the line.`

Using this variable in resources:
```
provider "google" {
  ...
  region  = local.location
}
```
