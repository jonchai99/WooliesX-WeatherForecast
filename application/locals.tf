locals {
  cloud_run_service_name = "${var.gcp_project_id}-cr"
  ip_address_name        = "${var.cloud_run_image_name}-address"
  backend_service_name   = "${var.cloud_run_image_name}-backend"
}
