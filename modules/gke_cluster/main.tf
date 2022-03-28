provider "google" {
  project = data.terraform_remote_state.base.outputs.project_id
  region  = data.terraform_remote_state.base.outputs.location
}

# Data block to retrieve output data from the base layer terraform statefile to be used in the resource block
data "terraform_remote_state" "base" {
  backend   = "gcs"
  workspace = terraform.workspace
  config = {
    bucket = "tfstate_file"
    prefix = "base"
  }
}

resource "google_container_cluster" "main_gke_cluster" {
  name                        = var.cluster_name
  location                    = data.terraform_remote_state.base.outputs.location

  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool    = true
  initial_node_count          = var.initial_nodes_count

  network                     = join("/", ["projects", data.terraform_remote_state.base.outputs.project_id, "global/networks", data.terraform_remote_state.base.outputs.network_name])
  subnetwork                  = join("/", ["projects", data.terraform_remote_state.base.outputs.project_id, "regions",data.terraform_remote_state.base.outputs.location,"subnetworks", data.terraform_remote_state.base.outputs.private-subnets])
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  count      = var.node_counts == 0 ? 1 : var.node_pool_counts
  name       = join("-", [var.node_name, count.index])
  location   = google_container_cluster.main_gke_cluster.location
  cluster    = google_container_cluster.main_gke_cluster.name
  node_count = var.node_counts

  node_config {
    preemptible  = true
    machine_type = var.node_machine_type

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = "${var.gke_service_account}@${data.terraform_remote_state.base.outputs.project_id}.iam.gserviceaccount.com"
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
