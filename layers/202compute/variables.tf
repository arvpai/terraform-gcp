
variable "function_name" {
  description = "A user-defined name of the function"
  default     = ""
}

variable "function_file_name" {
  description = "Name of the file that contains the code to execute"
  default     = ""
}

variable "function_file_path" {
  description = "Path to the zip file which contains the code"
  default     = ""
}

variable "function_description" {
  description = "Description of the function"
  default     = ""
}

variable "function_runtime" {
  description = "The runtime in which the function is going to run"
  default     = ""
}

variable "function_memory" {
  description = "Memory (in MB), available to the function"
  default     = 256
}

variable "function_trigger_http" {
  description = "Boolean variable. Any HTTP request (of a supported type) to the endpoint will trigger function execution"
  default     = false
}

variable "function_trigger_event_type" {
  description = "A source that fires events in response to a condition in another service"
  default     = "google.storage.object.finalize"
}

variable "function_timeout" {
  description = "Timeout (in seconds) for the function"
  default     = 60
}

variable "function_entrypoint" {
  description = "Name of the function that will be executed when the Google Cloud Function is triggered"
  default     = "get_object_metadata"
}

variable "function_role" {
  description = "IAM role to invoke the functions"
  default     = "allUsers"
}