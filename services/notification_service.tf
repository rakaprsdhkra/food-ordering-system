provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "notification_service" {
  metadata {
    name      = "notification-service"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "notification-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "notification-service"
        }
      }

      spec {
        container {
          image = "gcr.io/${var.project_id}/notification-service:latest"
          name  = "notification-service"
        }
      }
    }
  }
}

resource "kubernetes_service" "notification_service" {
  metadata {
    name      = "notification-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "notification-service"
    }

    port {
      protocol = "TCP"
      port     = 8080
      target_port = 8080
    }
  }
}