resource "aws_acm_certificate" "www-certificate" {
  domain_name       = "thecloudonmymind.com"
  validation_method = "DNS"
  subject_alternative_names = ["www.thecloudonmymind.com", "*.thecloudonmymind.com"]
}