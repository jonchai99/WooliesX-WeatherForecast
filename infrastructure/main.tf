resource "google_project_service" "artifact_registry_api" {
  project       = var.gcp_project_id
  service       = "artifactregistry.googleapis.com"
}

resource "google_project_service" "secret_manager_api" {
  project       = var.gcp_project_id
  service       = "secretmanager.googleapis.com"
}

resource "google_project_service" "cloud_run_api" {
  project       = var.gcp_project_id
  service       = "run.googleapis.com"
}

resource "time_sleep" "wait_180_seconds" {
  depends_on = [
    google_project_service.artifact_registry_api,
    google_project_service.secret_manager_api,
    google_project_service.cloud_run_api
  ]

  create_duration = "180s"
}

resource "google_artifact_registry_repository" "repository" {
  provider      = google-beta
  location      = var.gcp_region
  repository_id = local.repository_id
  format        = var.repository_format

  depends_on = [
    google_project_service.artifact_registry_api,
    time_sleep.wait_180_seconds
  ]  
}

resource "google_service_account" "pipeline_gar" {
  account_id   = "pipeline-gar"
  display_name = "Pipeline Service Account"
  description  = "Used by pipeline to push images into GAR registry."
  project      = var.gcp_project_id
}

resource "google_project_iam_member" "pipeline_gar_reg_rd" {
  project = var.gcp_project_id
  role    = "roles/artifactregistry.reader"
  member  = "serviceAccount:${google_service_account.pipeline_gar.email}"
}

resource "google_project_iam_member" "pipeline_gar_reg_wrt" {
  project = var.gcp_project_id
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.pipeline_gar.email}"
}

resource "google_project_iam_member" "compute_sa_secret_rd" {
  project = var.gcp_project_id
  role    = "roles/secretmanager.secretAccessor"
  member  = "serviceAccount:${data.google_project.project.number}-compute@developer.gserviceaccount.com"

  depends_on = [
    google_project_service.cloud_run_api,
    time_sleep.wait_180_seconds
  ]
}