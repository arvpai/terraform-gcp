output "id" {
  value       = google_compute_instance.instance.id
  description = "The id of GCP Compute Instance created by this module."
}

output "self_link" {
  value       = google_compute_instance.instance.self_link
  description = "The self_link of GCP Compute Instance created by this module."
}

output "all" {
  value       = google_compute_instance.instance
  description = "All outputs from google_compute_instance resource, see terraform / gcp provider documentation for more information."
}
