output "cloudflare_name_servers" {
  description = "Set these at Namecheap."
  value       = data.cloudflare_zone.main.name_servers
}

output "zone_status" {
  value = data.cloudflare_zone.main.status
}

output "pages_subdomain" {
  value = cloudflare_pages_project.site.subdomain
}
