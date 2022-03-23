terraform {
  backend "gcs" {
    bucket = "tf-state26226"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
    }    
  }
}