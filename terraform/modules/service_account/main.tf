terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "5.29.1"
        }
    }
}

data "google_client_openid_userinfo" "this" {
}

data "google_iam_policy" "this" {
    for_each = toset(var.roles)
    binding {
      role = each.key
      members = [
        "serviceAccount:${google_service_account.this.email}"
        ]
    }
}

resource "google_service_account" "this" {
    account_id   = var.account_id
    display_name = var.display_name
}

resource "google_service_account_iam_policy" "this" {
    for_each = toset(var.roles)
    service_account_id = google_service_account.this.id
    policy_data = data.google_iam_policy.this[each.key].policy_data
}

resource "google_service_account_iam_binding" "this" {
  service_account_id = google_service_account.this.name
  role               = "roles/iam.serviceAccountTokenCreator"

  members = [
    "user:${data.google_client_openid_userinfo.this.email}",
  ]
}