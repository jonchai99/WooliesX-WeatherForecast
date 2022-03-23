data "google_secret_manager_secret" "secret" {
  secret_id = var.cloud_run_api_key_secret
}