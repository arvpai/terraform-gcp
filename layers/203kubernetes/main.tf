terraform {
  backend "gcs" {
    bucket = "tfstate_file"
    prefix = "kubernetes"
  }
}

module "jupyter_notebooks_cluster" {
  source                    = "../../modules/gke_cluster"
  cluster_name              = "jupyter-notebook-server-cluster"
  node_name                 = "jupyter-notebook-server-node"
  gke_service_account       = "gke-service-account"
  node_pool_counts          = 3
  node_counts               = 3
  node_machine_type         = "e2-medium"
}
