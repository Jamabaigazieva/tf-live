provider "google" {
  credentials = base64decode(var.service_account_key)
  project     = var.project_id
  region      = var.region
}

resource "google_service_account" "github_service_account" {
  account_id   = var.account_id
  display_name = var.display_name
}

resource "google_project_iam_binding" "github_service_account_binding" {
  project = var.project_id
  role    = var.role
  members = [
    "serviceAccount:${google_service_account.github_service_account.email}",
  ]
}

resource "google_artifact_registry_repository" "my_repository" {
  project      = var.project_id
  location     = var.region
  repository_id = var.repository_id
  description  = var.repository_description
}

output "repository_name" {
  value = google_artifact_registry_repository.my_repository.name
}
