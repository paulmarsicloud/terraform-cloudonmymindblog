resource "aws_acm_certificate" "www-certificate" {
  domain_name       = "thecloudonmymind.com"
  validation_method = "DNS"
  subject_alternative_names = ["www.thecloudonmymind.com", "*.thecloudonmymind.com"]
}

resource "aws_acm_certificate_validation" "www-certificate-validation" {
  certificate_arn         = aws_acm_certificate.www-certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.www-cert-validation : record.fqdn]
}