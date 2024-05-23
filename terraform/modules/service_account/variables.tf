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

variable "display_name" {
    type = string
    description = "Display name of the Google Cloud service account"
}

variable "roles" {
    type = list(string)
    description = "List of policy roles to the assigned to the service account user"
}