output "email" {
    description = "Email address of the service account"
    value = google_service_account.this.email
}