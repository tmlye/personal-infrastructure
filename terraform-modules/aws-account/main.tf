locals {
  role_name = "assumedFromMaster"
}

resource "aws_organizations_account" "this" {
  name  = var.name
  email = var.email

  role_name = local.role_name

  # There is no AWS Organizations API for reading role_name
  lifecycle {
    ignore_changes = ["role_name"]
  }
}

resource "aws_iam_account_alias" "this" {
  provider = aws.new_account

  account_alias = var.name
}

resource "aws_iam_user" "terraform" {
  provider = aws.new_account

  name = "terraform"
}

resource "aws_iam_access_key" "terraform" {
  provider = aws.new_account

  user    = aws_iam_user.terraform.name
  pgp_key = "keybase:${var.keybase_username}"
}

resource "aws_iam_user_policy_attachment" "terraform_admin" {
  provider = aws.new_account

  user       = aws_iam_user.terraform.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
