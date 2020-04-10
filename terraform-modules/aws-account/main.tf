locals {
  role_name = "assumedFromMaster"
}

resource "aws_organizations_account" "this" {
  name  = var.name
  email = var.email

  role_name = local.role_name

  # There is no AWS Organizations API for reading role_name
  lifecycle {
    ignore_changes = [role_name]
  }
}

resource "aws_iam_account_alias" "this" {
  provider = aws.new_account

  account_alias = var.name
}
