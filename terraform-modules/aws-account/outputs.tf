output "id" {
  value = aws_organizations_account.this.id
}

output "arn" {
  value = aws_organizations_account.this.arn
}

output "state_bucket_id" {
  value = aws_s3_bucket.this.id
}

output "state_table_id" {
  value = aws_dynamodb_table.this.id
}
