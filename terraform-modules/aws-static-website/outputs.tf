output "name_servers" {
  value = aws_route53_zone.this.name_servers
}

output "deployment_access_key_id" {
  value = aws_iam_access_key.this.id
}

output "deployment_access_key_secret" {
  value = aws_iam_access_key.this.encrypted_secret
}

output "bucket_name" {
  value = aws_s3_bucket.this.id
}
