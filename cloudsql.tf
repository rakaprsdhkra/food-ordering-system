provider "google" {
  credentials = file("<path/to/credentials.json>")
  project     = "<project-id>"
  region      = "asia-southeast2"
}

resource "google_sql_database_instance" "food_ordering_db" {
  name             = "food-ordering-db"
  database_version = "POSTGRES_14"
  region           = "asia-southeast2"
  root_password    = "L0g1qu3!"

  settings {
    tier = "db-n1-standard-1"
  }
}