output "bucket_id" {
  value = aws_s3_bucket.this.id
}

output "table_id" {
  value = aws_dynamodb_table.this.id
}
