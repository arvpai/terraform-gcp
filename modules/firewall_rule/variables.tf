variable "rule_name" {
  type        = string
  description = "Name of the firewall rule"
}

variable "network_name" {
  type        = string
  description = "Name of the network this rule is to be applied to."
}

variable "allow_protocol" {
  type        = string
  description = "Protocol to be allowed."
  default     = "tcp"
}

variable "allow_ports" {
  type        = list(string)
  description = "List of ports to be allowed."
  default     = ["22"]
}

variable "tcp_ports" {
  type        = list(string)
  description = "List of ports to be allowed for TCP."
  default     = ["0-65535"]
}

variable "udp_ports" {
  type        = list(string)
  description = "List of ports to be allowed for UDP."
  default     = ["0-65535"]
}

variable "target_tags" {
  type        = list(string)
  description = "List of tags this firewall rule to be applied to."
}
