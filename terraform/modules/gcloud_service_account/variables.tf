variable "project" {
    description = "ID of the Google Cloud project"
}

variable "region" {
    description = "Name of region where the resources are needed to be deployed"
}

variable "account_id" {
    description = "Unique ID of the Google Cloud service account"
    type = string
}

variable "service_account_display_name" {
    type = string
    description = "Display name of the Google Cloud service account"
    default = "Service Account"
}