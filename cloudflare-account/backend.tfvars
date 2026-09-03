bucket = "terraform-state"
key    = "cloudflare-account.tfstate"
region = "auto"

endpoints = { s3 = "https://f01841d199c2465135bec873f2e3e534.r2.cloudflarestorage.com" }

profile = "cloudflare-r2"

use_lockfile = true

skip_credentials_validation = true
skip_region_validation      = true
skip_requesting_account_id  = true
skip_metadata_api_check     = true
skip_s3_checksum            = true
