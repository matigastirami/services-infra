resource "mongodbatlas_cluster" "example" {
  project_id           = "YOUR_PROJECT_ID"
  name                 = "my-atlas-cluster"
  provider_backup_enabled = true

  cluster_type {
    name = "M10"
  }

  num_shards = 1
  replication_factor = 3

  region_name = "US_EAST_1"

  auto_scaling {
    disk_gb_enabled = true
  }

  maintenance_window {
    day_of_week = "SUNDAY"
    start_hour  = 10
    start_minute = 0
  }
}