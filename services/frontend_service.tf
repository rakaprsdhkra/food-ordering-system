provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "frontend_service" {
  metadata {
    name      = "frontend-service"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "frontend-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "frontend-service"
        }
      }

      spec {
        container {
          image = "gcr.io/${var.project_id}/frontend-service:latest"
          name  = "frontend-service"
        }
      }
    }
  }
}

resource "kubernetes_service" "frontend_service" {
  metadata {
    name      = "frontend-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "frontend-service"
    }

    port {
      protocol = "TCP"
      port     = 8080
      target_port = 8080
    }
  }
}