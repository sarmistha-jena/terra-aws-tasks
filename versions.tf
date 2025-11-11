terraform {
  required_version = ">= 1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.19.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate" # Optional: Specify a custom path for the state file
  }
}