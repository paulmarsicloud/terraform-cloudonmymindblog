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
}

data "aws_iam_policy_document" "www_bucket_policy" {
  statement {
    sid = "PublicReadGetObject"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "arn:aws:s3:::www.thecloudonmymind.com/*",
    ]
  }
}

resource "aws_s3_bucket_policy" "www_bucket_policy" {
  bucket = aws_s3_bucket.www_bucket.id
  policy = data.aws_iam_policy_document.www_bucket_policy.json
}
