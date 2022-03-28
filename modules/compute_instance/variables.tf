variable "instance_name" {
  type        = string
  description = "The name of the instance."
}

variable "machine_type" {
  type        = string
  default     = "e2-small"
  description = "The type of the instance, defaults to e2-small."
}

variable "zone" {
  type        = string
  default     = "europe-west2-a"
  description = "The zone to launch this instance in."
}

variable "tags" {
  type        = list(string)
  default     = []
  description = "A list of tags to be applied to this instance."
}

variable "boot_image" {
  type        = string
  description = "The image to be used to create boot volume."
}

variable "boot_size" {
  type        = number
  description = "The size in GB for the boot volume."
}

variable "boot_type" {
  type        = string
  default     = "pd-balanced"
  description = "The type of the boot volume, defaults to pb-balanced."
}

variable "network" {
  type        = string
  description = "The network to launch the instance in."
}

variable "subnetwork" {
  type        = string
  description = "The subnetwork to launch this instance in."
}

variable "startup_script" {
  type        = string
  default     = ""
  description = "The startup script for instance bootstrapping."
}

variable "service_account" {
  description = "Service Account for using the Compute Engine"
  type        = string
}
