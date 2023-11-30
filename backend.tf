terraform {
  backend "s3" {
    bucket = "backendfile"
    key    = "backend/terraform.tfstate"
    region = "eu-central-1"
    dynamodb_table= "s3_terraform_lock"
  }
}
