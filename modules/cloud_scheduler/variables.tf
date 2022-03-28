variable "pubsub_scheduler_count"{
  description = "Sets if a PubSub scheduler should be created or not"
  type        = number
  default     = 0
}

variable "http_scheduler_count"{
  description = "Sets if an HTTP scheduler should be created or not"
  type        = number
  default     = 0
}

variable "scheduler_name"{
  description = "Scheduler name"
  type        = string
}

variable "scheduler_description"{
  description = "Scheduler description"
  type        = string
  default     = "Scheduler description"
}

variable "scheduler_schedule"{
  description = "Scheduler schedule - default is every Monday at 09:00"
  type        = string
  default     = "0 9 * * 1"
}

variable "scheduler_time_zone"{
  description = "Scheduler time zone"
  type        = string
  default     = "Europe/London"
}

variable "scheduler_deadline"{
  description = "Scheduler deadline"
  type        = string
  default     = "320s"
}

variable "scheduler_retries"{
  description = "Scheduler retries count"
  type        = number
  default     = 1
}

variable "scheduler_post_uri"{
  description = "Scheduler HTTP Entrypoint"
  type        = string
  default     = ""
}

variable "pubsub_target_topic"{
  description = "Pubsub target Topic to trigger"
  type        = string
}
