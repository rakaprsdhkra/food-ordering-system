provider "google" {
  credentials = file("<path/to/credentials.json>")
  project     = "<project-id>"
  region      = "asia-southeast2"
}

resource "google_compute_network" "vpc" {
  name                    = "food-ordering-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "food-ordering-subnet"
  ip_cidr_range = "10.0.0.0/24"
  network       = google_compute_network.vpc.name
}