# This provider assumes a role in the new account
provider "aws" {
  alias  = "new_account"
  region = "us-east-1"

  assume_role {
    role_arn     = "arn:aws:iam::${aws_organizations_account.this.id}:role/${local.role_name}"
    session_name = "bootstrap_terraform"
  }
}
