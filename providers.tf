provider "google"{
    credentials = file(var.credentials)

    project = var.project_id
    region = var.region
    zone = var.zone
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}