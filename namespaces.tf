resource "kubernetes_namespace" "production-ns" {
  metadata {
    annotations = {
      name = "production"
    }

    labels = {
      env = "production"
    }

    name = "production"
  }
}
resource "kubernetes_namespace" "development-ns" {
  metadata {
    annotations = {
      name = "development"
    }

    labels = {
      env = "development"
    }

    name = "development"
  }
}