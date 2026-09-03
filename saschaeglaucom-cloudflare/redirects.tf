resource "cloudflare_ruleset" "redirects" {
  zone_id = data.cloudflare_zone.main.id
  name    = "redirects"
  kind    = "zone"
  phase   = "http_request_dynamic_redirect"

  rules = [{
    description = "www to apex"
    expression  = "(http.host eq \"${local.www}\" and not starts_with(http.request.uri.path, \"/.well-known/\"))"
    action      = "redirect"
    enabled     = true
    action_parameters = {
      from_value = {
        status_code           = 301
        preserve_query_string = true
        target_url = {
          expression = "concat(\"https://${local.domain}\", http.request.uri.path)"
        }
      }
    }
    }, {
    description = "old /files/ paths to the files host"
    expression  = "(http.host eq \"${local.domain}\" and starts_with(http.request.uri.path, \"/files/\"))"
    action      = "redirect"
    enabled     = true
    action_parameters = {
      from_value = {
        status_code           = 301
        preserve_query_string = true
        target_url = {
          expression = "concat(\"https://${local.files_host}\", substring(http.request.uri.path, 6))"
        }
      }
    }
  }]
}
