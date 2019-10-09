module "terraform_state" {
  source = "../terraform-modules/aws-terraform-state"

  component           = "org"
  bucket_name         = var.bucket
  dynamodb_table_name = var.dynamodb_table
}

resource "aws_organizations_organization" "org" {
  aws_service_access_principals = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
  ]

  feature_set          = "ALL"
  enabled_policy_types = ["SERVICE_CONTROL_POLICY"]
}

module "personal_account" {
  source = "../terraform-modules/aws-account"

  profile          = var.profile
  name             = "personal-2"
  email            = "aws-personal-2@saschaeglau.com"
  keybase_username = var.keybase_username
}
