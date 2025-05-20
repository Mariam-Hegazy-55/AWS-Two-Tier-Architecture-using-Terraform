terraform {
  backend "s3" {
    bucket = "mariam-two-tier-app-project"
    key    = "two-tier-app/terraform.tfstate"
    region = "eu-west-2"
    
  }
}
