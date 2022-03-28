variable "bucket_name" {
  description = "Bucket name suffixes."
  type        = string
  default     = ""
}

variable "storage_class" {
  description = "Bucket storage class."
  type        = string
  default     = ""
}

variable "uniform_bucket_level_access" {
  description = "Enables Uniform bucket-level access access to a bucket. Change to 'false' to disable"
  type        = bool
  default     = true
}

variable "directory_names" {
  description = "List of directories to be created along with the bucket"
  type        = list
  default     = []
}

variable "object_names" {
  description = "List of objects to be created along with the bucket"
  type = map(
    object(
      {
        object_name        = string
        object_source      = string
      }
    )
  )
  default = {}
}
