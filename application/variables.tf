variable "gcp_project_id" {
  description = "Unique ID of the GCP Project"
  type        = string
}

variable "gcp_region" {
  description = "Primary region of the GCP Project"
  type        = string
}

variable "repository_id" {
  description = "Unique name that represents the repository"
  type        = string
}

variable "cloud_run_image_name" {
  description = "Name of the image to publish to Cloud Run"
  type        = string
}

variable "cloud_run_image_tag" {
  description = "Unique tag of the image to publish to Cloud Run"
  type        = string
}

variable "cloud_run_environment_variables" {
  description = "A map of key values environment variables for the application to function"
  type        = map(string)
  default     = {}
}

variable "cloud_run_api_key_secret" {
  description = "Secret ID of Cloud Run application stored in Secret Manager"
  type        = string
}
