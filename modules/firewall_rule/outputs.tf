output "id" {
  value       = google_compute_firewall.rule.id
  description = "The id of firewall rule created by this module."
}

output "self_link" {
  value       = google_compute_firewall.rule.self_link
  description = "The self_link of firewall rule created by this module."
}

output "all" {
  value       = google_compute_firewall.rule
  description = "All outputs from google_compute_firewall resource, see terraform / gcp provider documentation for more information."
}
