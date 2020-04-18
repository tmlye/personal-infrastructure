output "id" {
  value = aws_organizations_account.this.id
}

output "arn" {
  value = aws_organizations_account.this.arn
}

output "state_bucket_id" {
  value = module.terraform_state.bucket_id
}

output "state_table_id" {
  value = module.terraform_state.table_id
}
