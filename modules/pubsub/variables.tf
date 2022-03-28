variable "pubsub_topic_name" {
  description = "Pub/Sub topic name"
}

variable "pubsub_topic_creation" {
  description = "Flag to determine"
  type        = bool
  default     = false
}

variable "pubsub_subscription_name" {
  description = "Pub/Sub subscription name"
}

variable "pubsub_subscription_message_retention" {
  description = "Time the messages will be retained on the subscription"
  type = string
  default = "604800s"
}

variable "pubsub_subscription_retain_acked_messages" {
  description = "Acknowledged messages will be kept for the given day from publication unless set otherwise in 'message retention duration'"
  type = bool
  default = true
}

variable "pubsub_subscription_ack_deadline_seconds" {
  description = "How long Pub/Sub waits for the subscriber to acknowledge receipt before resending the message"
  type = number
  default = 10
}
