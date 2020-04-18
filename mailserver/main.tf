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
  records = ["10 mail.saschaeglau.com"]
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
  name    = "mail._domainkey"
  type    = "TXT"
  ttl     = "300"
  records = ["v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCpX5uXsqR9IqraWXdLG9lS8+1OnNz0nYUETKaM4KuNOdO8dBsKGt/B/Qfm7tQEAYGCl4qtvonV2WzhGRZatI1uzs/TTSQfqOvIThdlFqdYXVWjsgSnfxLsdUNja5QIcdEHaxoTJX+1xQKGVMflsPAfORx3pAboNoVOCtfR9mRIzwIDAQAB"]
}

resource "aws_route53_record" "spf1" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = "saschaeglau.com"
  type    = "TXT"
  ttl     = "300"
  records = ["v=spf1 mx a ?all"]
}
