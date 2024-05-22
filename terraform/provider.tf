provider "google" {
    region = "asia-south2"
    access_token = module.gcloud_service_account.service_account_email
}