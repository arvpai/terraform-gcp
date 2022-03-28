variable "cluster_name"{
  description = "GKE cluster name"
  type        = string
}

variable "initial_nodes_count" {
  description = "Number of initial nodes"
  type        = number
  default     = 1
}

variable "node_pool_counts" {
  description   = "Number of node pools"
  type          = number
  default       = 1
}

variable "node_counts" {
  description   = "Number of nodes"
  type          = number
  default       = 3
}

variable "node_name" {
  description = "Name of the nodes to be shown"
  type        = string
}

variable "node_machine_type" {
  type    = string
  default = "e2-micro"
}

variable "gke_service_account" {
  description = "Account ID for the serice account"
  type        = string
}
