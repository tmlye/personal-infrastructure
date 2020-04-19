resource "aws_acm_certificate" "this" {
  provider = aws.us-east-1

  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = ["www.${var.domain_name}"]

  tags = local.common_tags
}

resource "aws_acm_certificate_validation" "this" {
  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [
    aws_route53_record.cert_validation.fqdn,
    aws_route53_record.cert_validation_www.fqdn,
  ]
}
