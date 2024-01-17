provider "kubernetes" {
  config_path = "~/.kube/config"
}

resource "kubernetes_deployment" "menu_service" {
  metadata {
    name      = "menu-service"
    namespace = "default"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "menu-service"
      }
    }

    template {
      metadata {
        labels = {
          app = "menu-service"
        }
      }

      spec {
        container {
          image = "gcr.io/${var.project_id}/menu-service:latest"
          name  = "menu-service"
        }
      }
    }
  }
}

resource "kubernetes_service" "menu_service" {
  metadata {
    name      = "menu-service"
    namespace = "default"
  }

  spec {
    selector = {
      app = "menu-service"
    }

    port {
      protocol = "TCP"
      port     = 8080
      target_port = 8080
    }
  }
}