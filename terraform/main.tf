terraform {
    required_providers {
        google = {
            source = "hashicorp/google"
            version = "5.29.1"
        }
    }
}

module "gcloud_service_account" {
    source = "./modules/gcloud_service_account"
    region = "asia-south2"
    project = "playground-gkarthik"
    account_id = "playground-gitops"
    service_account_display_name = "GitOps Service Account"
}

module "gke_cluster" {
    source = "./modules/gke_cluster"
    region = "asia-south2"
    project = "playground-gkarthik"
}