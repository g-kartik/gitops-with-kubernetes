variable "project" {
    description = "ID of the Google Cloud project"
    type = string
    default = "playground-gkarthik"
}

variable "region" {
    description = "Region name for the resources"
    type = string
    default = "asia-south2"
}

variable "service_accounts" {
    type = map(object({
        display_name = string
        roles = optional(list(string), [])
    }))
    default = {
        "terraform" = {
            display_name = "Terraform Service Account"
        }
        "gke-cluster" = {
            display_name = "GKE Cluster Service Account"
        }
    }
}