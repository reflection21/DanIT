terraform {
  backend "s3" {
    bucket  = "terraform-state-danit-devops-8"
    key     = "artem/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}





