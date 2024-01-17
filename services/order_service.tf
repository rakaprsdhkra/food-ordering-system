provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "order_service" {
  metadata {
    name      = "order-service"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "order-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "order-service"
        }
      }

      spec {
        container {
          image = "gcr.io/${var.project_id}/order-service:latest"
          name  = "order-service"
        }
      }
    }
  }
}

resource "kubernetes_service" "order_service" {
  metadata {
    name      = "order-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "order-service"
    }

    port {
      protocol = "TCP"
      port     = 8080
      target_port = 8080
    }
  }
}