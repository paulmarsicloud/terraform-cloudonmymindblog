resource "aws_route53_zone" "blog_zone" {
  name = "thecloudonmymind.com"
}

resource "aws_route53_zone" "blog_www_zone" {
  name = "www.thecloudonmymind.com"
}

resource "aws_route53_record" "blog_www_zone_cname" {
  zone_id = aws_route53_zone.blog_zone.zone_id
  name    = "www.thecloudonmymind.com"
  type    = "A"
  ttl     = "30"
  records = [aws_s3_bucket.www_bucket.id]
}