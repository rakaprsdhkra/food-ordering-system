provider "google" {
  credentials = file("<path/to/credentials.json>")
  project     = "<project-id>"
  region      = "asia-southeast2"
}

resource "google_project_service" "logging" {
  project = "<project-id>"
  service = "logging.googleapis.com"
}

resource "google_project_service" "monitoring" {
  project = "<project-id>"
  service = "monitoring.googleapis.com"
}