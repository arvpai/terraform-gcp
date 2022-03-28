variable "project_id" {
  description = "The ID of the project where this VPC will be created"
  type        = string
  default     = "engineering-assets-319815"
}

variable "prefix" {
  description = "Prefix used to generate the project resources"
  default     = "data-asset"
}

variable "location" {
  type        = string
  description = "Location where VPC will be deployed"
  default     = "europe-west2"
}

variable "routing_mode" {
  type        = string
  default     = "GLOBAL"
  description = "The network routing mode (default 'GLOBAL')"
}


variable "network_description" {
  type        = string
  description = "An optional description of this resource. The resource must be recreated to modify this field."
  default     = ""
}

variable "auto_create_subnetworks" {
  type        = bool
  description = "When set to true, the network is created in 'auto subnet mode' and it will create a subnet for each region automatically across the 10.128.0.0/9 address range. When set to false, the network is created in 'custom subnet mode' so the user can explicitly connect subnetwork resources."
  default     = false
}

variable "delete_default_internet_gateway_routes" {
  type        = bool
  description = "If set, ensure that all routes within the network specified whose names begin with 'default-route' and with a next hop of 'default-internet-gateway' are deleted"
  default     = false
}

variable "mtu" {
  type        = number
  description = "The network MTU. Must be a value between 1460 and 1500 inclusive. If set to 0 (meaning MTU is unset), the network will default to 1460 automatically."
  default     = 0
}

variable "cidr_range_1" {
  type        = string
  description = "THE CIDR range from private-subnet-1"
  default     = "10.10.10.0/24"
}