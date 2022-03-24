resource "google_cloud_run_service" "cloud_run" {
  name     = "${local.cloud_run_service_name}-${var.environment}"
  location = var.gcp_region

  template {
    spec {
      containers {
        image = "${var.gcp_region}-docker.pkg.dev/${var.gcp_project_id}/${var.repository_id}/${var.cloud_run_image_name}:${var.cloud_run_image_tag}"

        dynamic "env" {
          for_each = var.cloud_run_environment_variables

          content {
            name  = env.key
            value = env.value
          }
        }

        env {
          name = "APIKEY"
          value_from {
            secret_key_ref {
              name = data.google_secret_manager_secret.secret.secret_id
              key  = "latest"
            }
          }
        }

        ports {
          container_port = 80
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale" = "20"
        "run.googleapis.com/client-name"   = var.cloud_run_image_name
      }
    }
  }

  autogenerate_revision_name = true
}

############################################
# Make Cloud Run publicly accessible
############################################
resource "google_cloud_run_service_iam_binding" "binding" {
  project  = google_cloud_run_service.cloud_run.project
  location = google_cloud_run_service.cloud_run.location
  service  = google_cloud_run_service.cloud_run.name
  role     = "roles/run.invoker"
  members = [
    "allUsers",
  ]

  depends_on = [
    google_cloud_run_service.cloud_run
  ]
}
