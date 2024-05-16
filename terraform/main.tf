terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "5.29.1"
        }
        local = {
            source = "hashicorp/local"
            version = "2.5.1"
        }
        time = {
            source = "hashicorp/time"
            version = "0.11.1"
        }
    }
}

provider "google" {
    project = "playground-gkarthik"
}

provider "local" {

}

locals {
    service_account_private_key_path = abspath("${path.root}/${var.service_account_private_key_filename}")
}

resource "google_service_account" "service_account" {
    account_id   = "playground-gitops"
    display_name = "GitOps Service Account"
}

resource "time_rotating" "google_service_key_rotation" {
    rotation_days = 30
}

resource "google_service_account_key" "service_account_key" {
    service_account_id = google_service_account.service_account.id
    private_key_type = "TYPE_GOOGLE_CREDENTIALS_FILE"
    key_algorithm = "KEY_ALG_RSA_2048"

    keepers = {
        rotation_time = time_rotating.google_service_key_rotation.rotation_rfc3339
    }
}

resource "local_sensitive_file" "service_account_private_key" {
    filename = local.service_account_private_key_path
    content = base64decode(google_service_account_key.service_account_key.private_key)
}

resource "google_project_iam_member" "project" {
    project = google_service_account.service_account.project
    role    = "roles/container.admin"
    member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_project_service" "google_project_service" {
    service = "container.googleapis.com"
}