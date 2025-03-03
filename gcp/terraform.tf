terraform{
    backend "gcs"{
        bucket = "solo-levelling-terraform-bucket"
        prefix = "terraform/state"
    }
}