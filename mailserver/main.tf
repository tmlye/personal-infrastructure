data "aws_route53_zone" "this" {
  name = "saschaeglau.com"
}

resource "aws_route53_record" "a" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "mail"
  type    = "A"
  ttl     = "300"
  records = ["146.185.164.127"]
}

resource "aws_route53_record" "mx" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "saschaeglau.com"
  type    = "MX"
  ttl     = "300"
  records = ["10 mail.protonmail.ch", "20 mailsec.protonmail.ch"]
}

resource "aws_route53_record" "dmarc" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "_dmarc"
  type    = "TXT"
  ttl     = "300"
  records = ["v=DMARC1; p=none"]
}

resource "aws_route53_record" "dkim" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "protonmail._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = ["protonmail.domainkey.duhrgqynk5kyflwwproro3mf2veekolrwbn4ns6xazgnc7n7qwwrq.domains.proton.ch."]
}

resource "aws_route53_record" "dkim2" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "protonmail2._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = ["protonmail2.domainkey.duhrgqynk5kyflwwproro3mf2veekolrwbn4ns6xazgnc7n7qwwrq.domains.proton.ch."]
}

resource "aws_route53_record" "dkim3" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "protonmail3._domainkey"
  type    = "CNAME"
  ttl     = "300"
  records = ["protonmail3.domainkey.duhrgqynk5kyflwwproro3mf2veekolrwbn4ns6xazgnc7n7qwwrq.domains.proton.ch."]
}

resource "aws_route53_record" "txt" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "saschaeglau.com"
  type    = "TXT"
  ttl     = "300"
  records = ["v=spf1 include:_spf.protonmail.ch mx ~all", "protonmail-verification=d6a8055393d0d756e9abefe1f65738ec50638e83"]
}
