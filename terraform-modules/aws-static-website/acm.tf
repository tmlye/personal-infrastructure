resource "aws_acm_certificate" "this" {
  provider = aws.us-east-1

  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "this" {
  provider = aws.us-east-1

  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}
