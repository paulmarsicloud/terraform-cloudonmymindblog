resource "aws_route53_zone" "blog_zone" {
  name    = "thecloudonmymind.com"
  comment = "Blog Route 53 zone"
}

resource "aws_route53_record" "blog_www_zone" {
  zone_id = aws_route53_zone.blog_zone.zone_id
  name    = "www.thecloudonmymind.com"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.www_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www_distribution.hosted_zone_id
    evaluate_target_health = false
  }
  depends_on = [aws_s3_bucket.www_bucket]
}

resource "aws_route53_record" "blog_zone_record" {
  zone_id = aws_route53_zone.blog_zone.zone_id
  name    = ""
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.redirect_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.redirect_distribution.hosted_zone_id
    evaluate_target_health = false
  }
  depends_on = [aws_s3_bucket.www_bucket]
}

resource "aws_route53_record" "www-cert-validation" {
  for_each = {
    for dvo in aws_acm_certificate.www-certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.blog_zone.zone_id
}
