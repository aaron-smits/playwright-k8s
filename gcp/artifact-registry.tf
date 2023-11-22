# Artifact Registry
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/artifact_registry_repository
resource "google_artifact_registry_repository" "my-repo" {
    repository_id = "pw-k8s"
    location      = var.region
    description   = "image repo"
    format        = "DOCKER"
}
