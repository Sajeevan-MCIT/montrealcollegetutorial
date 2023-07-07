terraform {
  required_version = ">= 0.12"
}

provider "google" {
  project_id = var.project_id
  region  = var.region
}
