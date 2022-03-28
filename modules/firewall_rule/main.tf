# firewall_rule module for creating a firewall rule, see README.md for more information on the use of this module.
# generating a random string to be appended to resource names that needs to be unique to avoid name-exist conflict
resource "random_string" "id" {
  length  = 12
  special = false
  upper   = false
}

resource "google_compute_firewall" "rule" {
  name    = join("-", [var.rule_name, random_string.id.result])
  network = var.network_name

  allow {
    protocol = var.allow_protocol
    ports    = var.allow_ports
  }

  target_tags = var.target_tags
}

resource "google_compute_firewall" "mysql_rule" {
  name    = var.rule_name
  network = var.network_name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = var.tcp_ports
  }

  allow {
    protocol = "udp"
    ports    = var.udp_ports
  }

  target_tags = var.target_tags
}
