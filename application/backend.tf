terraform {
  backend "gcs" {
    bucket = "tf-state26226"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
    }    
  }
}