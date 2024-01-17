provider "google" {
  credentials = file("<path/to/credentials.json>")
  project     = "<project-id>"
  region      = "asia-southeast2"
}

resource "google_project_service" "cloudbuild" {
  project = "<project-id>"
  service = "cloudbuild.googleapis.com"
}

resource "google_cloudbuild_trigger" "frontend_trigger" {
  name     = "frontend-build-trigger"

  github {
    owner  = "<github-owner>"
    name   = "<github-repo>"
    push {
      branch = "<repo-branch>"
    }
  }

  build {
    name    = "frontend-build"
    steps {
      name = "gcr.io/cloud-builders/docker"
      args = ["build", "-t", "gcr.io/${var.project_id}/frontend-service", "."]
    }
  }
}
