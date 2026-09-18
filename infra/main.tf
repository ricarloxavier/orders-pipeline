terraform {
  required_version = ">= 1.5.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 7.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_project_service" "sqladmin" {
  project            = var.project_id
  service            = "sqladmin.googleapis.com"
  disable_on_destroy = false
}

resource "google_sql_database_instance" "orders" {
  name                = "${var.name_prefix}-postgres"
  project             = var.project_id
  region              = var.region
  database_version    = "POSTGRES_16"
  deletion_protection = var.deletion_protection

  settings {
    tier                  = var.instance_tier
    edition               = "ENTERPRISE"
    availability_type     = "ZONAL"
    disk_type             = "PD_SSD"
    disk_size             = 10
    disk_autoresize       = true
    connector_enforcement = "REQUIRED"

    backup_configuration {
      enabled                        = true
      point_in_time_recovery_enabled = true
      start_time                     = "03:00"
      transaction_log_retention_days = 7

      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
    }

    ip_configuration {
      ipv4_enabled = true
    }

    user_labels = {
      workload = "orders-pipeline"
    }
  }

  depends_on = [google_project_service.sqladmin]
}

resource "google_sql_database" "orders" {
  name     = var.database_name
  project  = var.project_id
  instance = google_sql_database_instance.orders.name
}

resource "google_sql_user" "pipeline" {
  name     = var.database_user
  project  = var.project_id
  instance = google_sql_database_instance.orders.name
  password = var.database_password
}

