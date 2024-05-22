output "service_account_email" {
    description = "Email address of the service accoount"
    value = google_service_account.service_account.email
}