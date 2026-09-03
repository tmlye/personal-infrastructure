# Public files that stay out of git, for example the resume. Served at files.saschaeglau.com.
# Upload: aws s3 cp <file> s3://saschaeglaucom-files/<name> --profile cloudflare-r2 --region auto --endpoint-url https://f01841d199c2465135bec873f2e3e534.r2.cloudflarestorage.com
locals {
  files_host = "files.${local.domain}"
}

resource "cloudflare_r2_bucket" "files" {
  account_id    = data.cloudflare_zone.main.account.id
  name          = "saschaeglaucom-files"
  location      = "weur"
  storage_class = "Standard"
}

# Cloudflare creates the DNS record for this host on its own.
resource "cloudflare_r2_custom_domain" "files" {
  account_id  = data.cloudflare_zone.main.account.id
  bucket_name = cloudflare_r2_bucket.files.name
  domain      = local.files_host
  zone_id     = data.cloudflare_zone.main.id
  enabled     = true
  min_tls     = "1.2"
}
