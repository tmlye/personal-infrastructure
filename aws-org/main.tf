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

resource "aws_organizations_account" "personal" {
  name  = "personal"
  email = "aws-personal@saschaeglau.com"
}
