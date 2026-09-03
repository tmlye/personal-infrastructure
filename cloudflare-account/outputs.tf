output "terraform_state_bucket" {
  value = cloudflare_r2_bucket.terraform_state.name
}
