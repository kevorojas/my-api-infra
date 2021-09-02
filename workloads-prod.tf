resource "kubernetes_service" "my-api-prod-svc" {
  metadata {
    name = "my-api"
    namespace = "production"
  }
  spec {
    selector = {
      app = kubernetes_deployment.my-api-prod-deploy.metadata.0.labels.app
    }
    session_affinity = "ClientIP"
    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}

resource "kubernetes_deployment" "my-api-prod-deploy" {
  metadata {
    name = "my-api"
    labels = {
      app = "my-api"
    }
    namespace = "production"
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        app = "my-api"
      }
    }

    template {
      metadata {
        labels = {
          app = "my-api"
        }
      }

      spec {
        container {
          image = "krojas4/my-api:latest"
          name  = "my-api"
          port {
            container_port = 5000
          }

          resources {
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          env {
            name = "SECRET_KEY"
            value = var.secret_key
          }
          env {
            name = "API_KEY"
            value = var.api_key
          }
        }
      }
    }
  }
}