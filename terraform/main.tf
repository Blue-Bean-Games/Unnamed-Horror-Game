terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.12.0"
    }
  }
  backend "http" {}
}


provider "google" {
  project = "blue-bean-games"
  region  = "eu-west2"
}
