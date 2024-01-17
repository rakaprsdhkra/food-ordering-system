provider "google" {
  credentials = file("<path/to/credentials.json>")
  project     = "<project-id>"
  region      = "asia-southeast2"
}

resource "helm_release" "istio" {
  name       = "istio"
  repository = "https://istio.io/charts"
  chart      = "istio-base"
  namespace  = "istio-system"
  version    = "1.11.3"

  set {
    name  = "global.hub"
    value = "docker.io/istio"
  }

  set {
    name  = "global.tag"
    value = "1.11.3"
  }
}