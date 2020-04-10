output "backup_user_access_key_id" {
  value = aws_iam_access_key.this.id
}

output "backup_user_access_key_secret" {
  value = aws_iam_access_key.this.encrypted_secret
}
