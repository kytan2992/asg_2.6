terraform {
  backend "s3" {
    bucket = "ky-s3-terraform"
    key    = "ky-tf-iam-database.tfstate"
    region = "us-east-1"
  }
}