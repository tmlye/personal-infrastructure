variable "domain_name" {
  type        = string
  description = "Domain name of the website, e.g. example.com"
}

variable "component" {
  type        = string
  description = "Component this website belongs to"
}

variable "environment" {
  type        = string
  description = "Environment this website is in, e.g. dev/prod"
}

variable "keybase_username" {
  type        = string
  description = "Keybase username for encrypting the deployment key secret"
}
