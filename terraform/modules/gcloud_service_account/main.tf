terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "5.29.1"
        }
    }
}

data "google_client_openid_userinfo" "current_auth_user" {
}

data "google_iam_policy" "service_account" {
    binding {
      role = "roles/iam.serviceAccountTokenCreator"

      members = [ 
            "user:${data.google_client_openid_userinfo.current_auth_user.email}",
       ]
    }
}

resource "google_service_account" "service_account" {
    account_id   = var.account_id
    display_name = var.service_account_display_name
}

resource "google_service_account_iam_policy" "service_account_policy" {
    service_account_id = google_service_account.service_account.id
    policy_data = data.google_iam_policy.service_account.policy_data
}

resource "google_project_iam_binding" "project" {
  project = var.project
  role    = "roles/container.admin"

  members = [
    "serviceAccount:${google_service_account.service_account.email}",
  ]
}

resource "google_project_service" "google_project_service" {
    service = "container.googleapis.com"
}