variable "project_id" {
  description = "Google Cloud project ID."
  type        = string
}

variable "region" {
  description = "Cloud SQL region."
  type        = string
  default     = "us-east1"
}

variable "name_prefix" {
  description = "Prefix for provisioned resource names."
  type        = string
  default     = "orders-pipeline"
}

variable "instance_tier" {
  description = "Cloud SQL machine tier. The default is for demonstration, not an SLA-backed production workload."
  type        = string
  default     = "db-f1-micro"
}

variable "database_name" {
  description = "PostgreSQL database name."
  type        = string
  default     = "orders"
}

variable "database_user" {
  description = "PostgreSQL application user."
  type        = string
  default     = "orders_pipeline"
}

variable "database_password" {
  description = "PostgreSQL application password. Supply securely; Terraform state may retain this value."
  type        = string
  sensitive   = true
}

variable "deletion_protection" {
  description = "Protect the Cloud SQL instance from accidental deletion."
  type        = bool
  default     = true
}

