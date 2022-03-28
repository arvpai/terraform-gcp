output "topic_name"{
  value   = google_pubsub_subscription.pubsub_subscription.topic
}

output "subscription_name"{
  value   = google_pubsub_subscription.pubsub_subscription.name
}
