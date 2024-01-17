provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "payment_service" {
  metadata {
    name      = "payment-service"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "payment-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "payment-service"
        }
      }

      spec {
        container {
          image = "gcr.io/${var.project_id}/payment-service:latest"
          name  = "payment-service"
        }
      }
    }
  }
}

resource "kubernetes_service" "payment_service" {
  metadata {
    name      = "payment-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "payment-service"
    }

    port {
      protocol = "TCP"
      port     = 8080
      target_port = 8080
    }
  }
}