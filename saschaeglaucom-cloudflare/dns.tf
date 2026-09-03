locals {
  dkim_target = "domainkey.duhrgqynk5kyflwwproro3mf2veekolrwbn4ns6xazgnc7n7qwwrq.domains.proton.ch"

  mail_records = {
    mx_primary   = { name = local.domain, type = "MX", content = "mail.protonmail.ch", priority = 10 }
    mx_secondary = { name = local.domain, type = "MX", content = "mailsec.protonmail.ch", priority = 20 }
    spf          = { name = local.domain, type = "TXT", content = "v=spf1 include:_spf.protonmail.ch mx ~all" }
    proton_verif = { name = local.domain, type = "TXT", content = "protonmail-verification=d6a8055393d0d756e9abefe1f65738ec50638e83" }
    dmarc        = { name = "_dmarc.${local.domain}", type = "TXT", content = "v=DMARC1; p=none" }
    dkim_1       = { name = "protonmail._domainkey.${local.domain}", type = "CNAME", content = "protonmail.${local.dkim_target}" }
    dkim_2       = { name = "protonmail2._domainkey.${local.domain}", type = "CNAME", content = "protonmail2.${local.dkim_target}" }
    dkim_3       = { name = "protonmail3._domainkey.${local.domain}", type = "CNAME", content = "protonmail3.${local.dkim_target}" }
  }

  site_target  = var.site_origin == "pages" ? "${local.pages_project_name}.pages.dev" : var.cloudfront_domain
  site_proxied = var.site_origin == "pages"
}

# Mail stays DNS only. A proxied DKIM CNAME breaks signature lookups.
resource "cloudflare_dns_record" "mail" {
  for_each = local.mail_records

  zone_id  = data.cloudflare_zone.main.id
  name     = each.value.name
  type     = each.value.type
  content  = each.value.content
  priority = try(each.value.priority, null)
  proxied  = false
  ttl      = 1
}

resource "cloudflare_dns_record" "site" {
  for_each = toset([local.domain, local.www])

  zone_id = data.cloudflare_zone.main.id
  name    = each.value
  type    = "CNAME"
  content = local.site_target
  proxied = local.site_proxied
  ttl     = 1
}

# ACM renews the CloudFront certificate through these. They go away with CloudFront.
locals {
  acm_validation_records = var.site_origin == "cloudfront" ? {
    acm_apex = { name = "_d84cfe91aaae2abb384b536c0b75d332.${local.domain}", content = "_69ea44b6395262bcf75c7b42bc29f856.nhqijqilxf.acm-validations.aws" }
    acm_www  = { name = "_4967ebec83f9d6d99c63f7107b0ec022.${local.www}", content = "_65a64b7e222d29599872104dda72dd86.nhqijqilxf.acm-validations.aws" }
  } : {}
}

resource "cloudflare_dns_record" "acm_validation" {
  for_each = local.acm_validation_records

  zone_id = data.cloudflare_zone.main.id
  name    = each.value.name
  type    = "CNAME"
  content = each.value.content
  proxied = false
  ttl     = 1
}
