terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}

# Define the Cloud SQL instance resource
resource "google_sql_database_instance" "default" {
  name             = "postgresql-instance"
  database_version = "POSTGRES_14"
  region           = "europe-west1"
  deletion_protection = true
  settings {
    availability_type = "ZONAL"
    ip_configuration {
      ipv4_enabled = false
      authorized_networks {
        name  = "groupnet"
        value = "10.0.0.0/24"
      }
    }
    backup_configuration {
      enabled = true
    }
    database_flags {
      name  = "cloudsql_mysql_ssl_mode"
      value = "REQUIRED"
    }
    database_flags {
      name  = "cloudsql_mysql_client_certificate_enforce"
      value = "ON"
    }
    maintenance_window {
      day  = "1"
      hour = "2"
    }
    replication {
      automatic_storage_increase = true
    }
    storage_auto_increase = true
    tier                   = "db-custom-1-3840"
    data_disk_size_gb      = "10"
    data_disk_type         = "PD_SSD"
    max_connections        = "100"
    max_disk_size_gb       = "100"
    min_disk_size_gb       = "10"
    storage_auto_release   = true
    backup_retention_period = "7"
  }
}
  

