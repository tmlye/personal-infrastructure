variable "keybase_username" {
  type        = string
  description = "Keybase username for encrypting the backup user's secret"
}

variable "region" {
  type        = string
  description = "AWS region to use for the provider"
}

variable "profile" {
  type        = string
  description = "AWS profile to use for the provider"
}
