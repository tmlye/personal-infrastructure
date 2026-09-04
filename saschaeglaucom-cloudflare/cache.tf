resource "cloudflare_ruleset" "cache" {
  zone_id = data.cloudflare_zone.main.id
  name    = "cache"
  kind    = "zone"
  phase   = "http_request_cache_settings"

  rules = [{
    description = "files host is not cached, uploads show at once"
    expression  = "(http.host eq \"${local.files_host}\")"
    action      = "set_cache_settings"
    enabled     = true
    action_parameters = {
      cache = false
    }
  }]
}
