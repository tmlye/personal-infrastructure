module "terraform_state" {
  source = "../terraform-modules/aws-terraform-state"

  name_prefix = "org"
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

module "scp_allow_list" {
  source = "../terraform-modules/aws-scp-allow-list"
}

module "personal_account_allow_list_attachment" {
  source = "../terraform-modules/aws-scp-attachment"

  aws_profile = var.profile
  policy_id   = module.scp_allow_list.id
  target_id   = module.personal_account.id
}
