variable "db_name" {
  description = "The name of the Instance to be created"
  type = string
}

variable "db_version" {
  description = "The version of of the database. For example, MYSQL_5_6 or MYSQL_5_7"
  type = string
  default = "MYSQL_8_0"
}

variable "db_tier" {
  description = "The machine tier (First Generation) or type (Second Generation). Reference: https://cloud.google.com/sql/pricing"
  type = string
  default = "db-f1-micro"
}

variable "db_activation_policy" {
  description = "Specifies when the instance should be active. Options are ALWAYS, NEVER or ON_DEMAND"
  type = string
  default = "ALWAYS"
}

variable "db_disk_autoresize" {
  description = "Second Generation only. Configuration to increase storage size automatically."
  default = true
}
variable "db_disk_size" {
  description = "Second generation only. The size of data disk, in GB. Size of a running instance cannot be reduced but can be increased."
  default = 10
}

variable "db_disk_type" {
  description = "Second generation only. The type of data disk: PD_SSD or PD_HDD"
  default = "PD_HDD"
}
variable "db_pricing_plan" {
  description = "First generation only. Pricing plan for this instance, can be one of PER_USE or PACKAGE"
  default = "PER_USE"
}

variable "db_username" {
  description = "Instancce user to access the information contained here"
  default = "root"
}

variable "db_password" {
  description = "Password for the user created earlier"
  default = ""
}
