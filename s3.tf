terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "blog"
  region  = "us-east-1"
}

resource "aws_s3_bucket" "www_bucket" {
  bucket = "www.thecloudonmymind.com"
  acl    = "public-read"
  website {
    index_document = "index.html"
  }
}

resource "aws_s3_bucket_policy" "www_bucket_policy" {
  bucket     = aws_s3_bucket.www_bucket.id
  depends_on = [aws_s3_bucket.www_bucket]
  policy     = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "PublicReadAllow",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::www.thecloudonmymind.com/*"
    }
  ]
}
POLICY
}

resource "aws_s3_bucket" "redirect_bucket" {
  bucket = "thecloudonmymind.com"
  acl    = "public-read"
  website {
    redirect_all_requests_to = "www.thecloudonmymind.com"
  }
}

resource "aws_s3_bucket_policy" "redirect_bucket_policy" {
  bucket     = aws_s3_bucket.redirect_bucket.id
  depends_on = [aws_s3_bucket.redirect_bucket]
  policy     = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "PublicReadAllow",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::thecloudonmymind.com/*"
    }
  ]
}
POLICY
}