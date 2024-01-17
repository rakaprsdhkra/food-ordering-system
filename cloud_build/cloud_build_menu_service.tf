provider "google" {
  credentials = file("<path/to/credentials.json>")
  project     = "<project-id>"
  region      = "asia-southeast2"
}

resource "google_project_service" "cloudbuild" {
  project = "<project-id>"
  service = "cloudbuild.googleapis.com"
}

resource "google_cloudbuild_trigger" "menu_trigger" {
  name     = "menu-build-trigger"

  github {
    owner  = "<github-owner>"
    name   = "<github-repo>"
    push {
      branch = "<repo-branch>"
    }
  }

  build {
    name    = "menu-build"
    steps {
      name = "gcr.io/cloud-builders/docker"
      args = ["build", "-t", "gcr.io/${var.project_id}/menu-service", "."]
    }
  }
}
