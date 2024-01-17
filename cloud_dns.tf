provider "google" {
  credentials = file("<path/to/credentials.json>")
  project     = "<project-id>"
  region      = "asia-southeast2"
}

resource "google_dns_managed_zone" "food_ordering_dns" {
  name        = "food-ordering-zone"
  dns_name    = "<domain-name>"
}

resource "google_dns_record_set" "frontend_record_set" {
  managed_zone = google_dns_managed_zone.food_ordering_dns.name
  name         = "frontend"
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["<frontend-service-ip-or-dns>"]
}

locals {
  backend_services = ["user", "menu", "order", "payment", "notification"]
}

resource "google_dns_record_set" "backend_record_sets" {
  for_each = { for svc in local.backend_services : svc => svc }

  managed_zone = google_dns_managed_zone.food_ordering_dns.name
  name         = each.value
  type         = "CNAME"
  ttl          = 300
  rrdatas      = ["<backend-service-ip-or-dns>"]
}
