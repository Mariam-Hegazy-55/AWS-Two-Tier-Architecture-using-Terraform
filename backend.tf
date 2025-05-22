terraform {
  backend "s3" {
    bucket = "mariam-backend"
    key    = "two-tier-app/terraform.tfstate"
    region = "eu-west-2"

  }
}
