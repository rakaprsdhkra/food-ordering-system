provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "user_service" {
  metadata {
    name      = "user-service"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "user-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "user-service"
        }
      }

      spec {
        container {
          image = "gcr.io/${var.project_id}/user-service:latest"
          name  = "user-service"
        }
      }
    }
  }
}

resource "kubernetes_service" "user_service" {
  metadata {
    name      = "user-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "user-service"
    }

    port {
      protocol = "TCP"
      port     = 8081
      target_port = 8081
    }
  }
}