terraform {
  backend "s3" {} # configured on init via backend.tfvars
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.75"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.3"
    }
  }
  required_version = ">= 1.2"
}
