terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "5.29.1"
        }
    }
}

module "service_account" {
    for_each = var.service_accounts
    source = "./modules/service_account"
    region = var.region
    project = var.project
    account_id = each.key
    display_name = each.value.display_name
    roles = each.value.roles
}

module "cluster" {
    source = "./modules/gke_cluster"
    region = var.region
    project = var.project
    providers = {
        google = google.gke_cluster
    }
}

resource "google_project_service" "google_project_service" {
    service = "container.googleapis.com"
}

resource "google_project_iam_binding" "project" {
  project = var.project
  role    = "roles/container.admin"
  members = [
    "serviceAccount:${module.service_account["gke-cluster"].email}",
  ]
}
