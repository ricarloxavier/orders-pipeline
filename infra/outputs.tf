output "instance_connection_name" {
  description = "Connection name used by the Cloud SQL Auth Proxy and Cloud Run integration."
  value       = google_sql_database_instance.orders.connection_name
}

output "database_name" {
  value = google_sql_database.orders.name
}

output "database_user" {
  value = google_sql_user.pipeline.name
}

