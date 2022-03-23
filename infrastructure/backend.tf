terraform {
  backend "gcs" {
    bucket = "tf-state62626"
    prefix = "terraform/state"
  }

  required_providers {
    google = {
      source = "hashicorp/google"
    }    
  }
}