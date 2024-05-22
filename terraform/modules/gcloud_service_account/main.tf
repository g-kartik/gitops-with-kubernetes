terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "5.29.1"
        }
    }
}

resource "google_service_account" "service_account" {
    account_id   = var.account_id
    display_name = var.service_account_display_name
}

resource "google_project_iam_member" "project" {
    project = var.project
    role    = "roles/container.admin"
    member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_service" "google_project_service" {
    service = "container.googleapis.com"
}