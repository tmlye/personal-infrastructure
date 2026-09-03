locals {
  domain = "saschaeglau.com"
  www    = "www.${local.domain}"
}

data "cloudflare_zone" "main" {
  filter = {
    name = local.domain
  }
}

resource "cloudflare_zone_setting" "ssl" {
  zone_id    = data.cloudflare_zone.main.id
  setting_id = "ssl"
  value      = "strict"
}

resource "cloudflare_zone_setting" "always_use_https" {
  zone_id    = data.cloudflare_zone.main.id
  setting_id = "always_use_https"
  value      = "on"
}

resource "cloudflare_zone_setting" "min_tls_version" {
  zone_id    = data.cloudflare_zone.main.id
  setting_id = "min_tls_version"
  value      = "1.2"
}

resource "cloudflare_zone_setting" "email_obfuscation" {
  zone_id    = data.cloudflare_zone.main.id
  setting_id = "email_obfuscation"
  value      = "off"
}
