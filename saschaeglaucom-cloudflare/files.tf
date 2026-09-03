locals {
  files_host = "files.${local.domain}"
}

resource "cloudflare_r2_bucket" "files" {
  account_id    = data.cloudflare_zone.main.account.id
  name          = "saschaeglaucom-files"
  location      = "weur"
  storage_class = "Standard"
}

resource "cloudflare_r2_custom_domain" "files" {
  account_id  = data.cloudflare_zone.main.account.id
  bucket_name = cloudflare_r2_bucket.files.name
  domain      = local.files_host
  zone_id     = data.cloudflare_zone.main.id
  enabled     = true
  min_tls     = "1.2"
}
