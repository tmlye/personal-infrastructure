terraform {
  backend "s3" {} # configured on init via backend.tfvars
  required_version = "> 0.12.0"
}
