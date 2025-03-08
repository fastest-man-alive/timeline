resource "google_storage_bucket" "test_bucket" {
    name = "terraform-test-bucket"
    location = var.region
    storage_class = "STANDARD"
    project = var.project
}