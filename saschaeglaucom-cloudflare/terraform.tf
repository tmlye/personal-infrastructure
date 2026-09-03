terraform {
  backend "s3" {} # configured on init via backend.tfvars
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.10"
}
