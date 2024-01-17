provider "google" {
  credentials = file("<path/to/credentials.json>")
  project     = "<project-id>"
  region      = "asia-southeast2"
}

resource "google_container_cluster" "food_ordering_cluster" {
  name     = "food-ordering-cluster"
  location = "asia-southeast2"
  network  = google_compute_network.vpc.name

  initial_node_count = 2

  node_config {
    preemptible  = false
    machine_type = "e2-standard-2"
  }
}