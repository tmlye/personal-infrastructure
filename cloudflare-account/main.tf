resource "cloudflare_r2_bucket" "terraform_state" {
  account_id    = var.account_id
  name          = "terraform-state"
  location      = "weur"
  storage_class = "Standard"
}
