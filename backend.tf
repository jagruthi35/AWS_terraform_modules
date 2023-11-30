terraform {
  backend "s3" {
    bucket = "terrastatefil"
    key    = "backend/terraform.tfstate"
    region = "eu-central-1"
  }
}
