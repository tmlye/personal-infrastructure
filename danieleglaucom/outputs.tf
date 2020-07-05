output "name_servers" {
  value = module.website.name_servers
}

output "bucket_name" {
  value = module.website.bucket_name
}

output "deployment_access_key_id" {
  value = module.website.deployment_access_key_id
}

output "deployment_access_key_secret" {
  value = module.website.deployment_access_key_secret
}
