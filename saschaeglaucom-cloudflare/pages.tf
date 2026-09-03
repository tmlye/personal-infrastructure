locals {
  pages_project_name = "saschaeglaucom"
}

# Needs the Cloudflare Pages GitHub app connected to the account first (dashboard, one time).
resource "cloudflare_pages_project" "site" {
  account_id        = data.cloudflare_zone.main.account.id
  name              = local.pages_project_name
  production_branch = "master"

  build_config = {
    build_command   = "hugo --minify"
    destination_dir = "public"
    build_caching   = true
  }

  source = {
    type = "github"
    config = {
      owner                          = "tmlye"
      repo_name                      = "saschaeglaucom"
      production_branch              = "master"
      production_deployments_enabled = true
      preview_deployment_setting     = "all"
      pr_comments_enabled            = true
    }
  }

  deployment_configs = {
    production = {
      env_vars = {
        HUGO_VERSION = { type = "plain_text", value = "0.108.0" }
      }
    }
    preview = {
      env_vars = {
        HUGO_VERSION = { type = "plain_text", value = "0.108.0" }
      }
    }
  }
}

resource "cloudflare_pages_domain" "site" {
  for_each = var.site_origin == "pages" ? toset([local.domain, local.www]) : toset([])

  account_id   = data.cloudflare_zone.main.account.id
  project_name = cloudflare_pages_project.site.name
  name         = each.value
}
