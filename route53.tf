resource "aws_route53_zone" "blog_zone" {
  name    = "thecloudonmymind.com"
  comment = "Blog Route 53 zone"
}

resource "aws_route53_record" "blog_www_zone" {
  zone_id = aws_route53_zone.blog_zone.zone_id
  name    = "www.thecloudonmymind.com"
  type    = "A"
  alias {
    name                   = aws_s3_bucket.www_bucket.website_domain
    zone_id                = aws_s3_bucket.www_bucket.hosted_zone_id
    evaluate_target_health = false
  }
  depends_on = [aws_s3_bucket.www_bucket]
}

resource "aws_route53_record" "blog_zone_record" {
  zone_id = aws_route53_zone.blog_zone.zone_id
  name    = "thecloudonmymind.com"
  type    = "A"
  alias {
    name                   = aws_s3_bucket.www_bucket.website_domain
    zone_id                = aws_s3_bucket.www_bucket.hosted_zone_id
    evaluate_target_health = false
  }
  depends_on = [aws_s3_bucket.www_bucket]
}