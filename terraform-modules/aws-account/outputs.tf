output "access_key_id" {
  value = aws_iam_access_key.terraform.id
}

output "access_key_secret" {
  value = aws_iam_access_key.terraform.encrypted_secret
}

output "id" {
  value = aws_organizations_account.this.id
}

output "arn" {
  value = aws_organizations_account.this.arn
}
