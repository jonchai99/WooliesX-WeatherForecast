variable "gcp_project_id" {
  description = "Unique ID of the GCP Project"
  type        = string
}

variable "gcp_region" {
  description = "Primary region of the GCP Project"
  type        = string
}

variable "repository_format" {
  description = "Format that the repository supports"
  type        = string

  validation {
    condition     = contains(["DOCKER", "MAVEN", "NPM", "PYTHON", "APT", "YUM", "HELM"], var.repository_format)
    error_message = "Valid values are DOCKER, MAVEN, NPM, PYTHON, APT, YUM and HELM."
  }  
}
