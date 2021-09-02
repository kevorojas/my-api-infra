resource "google_service_account" "terraform-sv-account" {
  account_id   = var.sva_account_id
  display_name = var.sva_display_name
}

resource "google_container_cluster" "my-api-cluster" {
  name     = var.cluster_name
  location = var.location
  remove_default_node_pool = true
  initial_node_count = var.initial_node_count
}

resource "google_container_node_pool" "my-api-node-pool" {
  name       = var.node_pool_name
  location   = var.location
  cluster    = google_container_cluster.my-api-cluster.name
  
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "e2-standard-2"
    service_account = google_service_account.terraform-sv-account.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

