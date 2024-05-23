provider "google" {
    region = var.region
    project = var.project
    scopes = [
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/userinfo.email",
    ]
}

data "google_service_account_access_token" "terraform" {
    target_service_account = module.service_account["terraform"].email
    scopes = [
        "userinfo-email",
        "cloud-platform"
    ]
    lifetime = "3600s"
}

data "google_service_account_access_token" "gke_cluster" {
    target_service_account = module.service_account["gke-cluster"].email
    scopes = [
        "userinfo-email",
        "cloud-platform"
    ]
    lifetime = "3600s"
}

provider "google" {
    region = var.region
    project = var.project
    alias = "terraform"
    access_token = data.google_service_account_access_token.terraform.access_token
}

provider "google" {
    region = var.region
    project = var.project
    alias = "gke_cluster"
    access_token = data.google_service_account_access_token.gke_cluster.access_token
}

