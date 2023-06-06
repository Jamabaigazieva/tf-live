provider "google" {
  project = "glossy-infinity-382611"
  region  = "us-central1-c"
}

resource "google_service_account" "github_service_account" {
  account_id   = "jama-service-acc"
  display_name = "jama-service-acc"
}

resource "google_project_iam_binding" "github_service_account_binding" {
  project = "glossy-infinity-382611"
  role    = "roles/iam.serviceAccountTokenCreator"
  members = [
"serviceAccount:${google_service_account.github_service_account.email}"
  ]
}

resource "google_project_iam_member" "artifact_registry_member" {
  project = "glossy-infinity-382611"
  role    = "roles/artifactregistry.writer"
  member  = "serviceAccount:${google_service_account.github_service_account.email}"
}



resource "google_artifact_registry_repository" "my_repository" {
  project       = "glossy-infinity-382611"
  location      = "us-central1"
  repository_id = "jama-repo-project"
  description   = "jama-repo-project"
  format        = "DOCKER"

}

resource "google_artifact_registry_repository" "my_repository2" {
  project       = "glossy-infinity-382611"
  location      = "us-central1"
  repository_id = "jama-repo-project-helm"
  description   = "jama-repo-project-helm"
  format        = "DOCKER"

}

output "repository_name" {
  value = google_artifact_registry_repository.my_repository.name
}

output "service_account_email" {
  value = google_service_account.github_service_account.email
}

