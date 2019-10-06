output "access_key_id" {
  value = aws_iam_access_key.terraform.id
}

output "access_key_secret" {
  value = aws_iam_access_key.terraform.encrypted_secret
}
