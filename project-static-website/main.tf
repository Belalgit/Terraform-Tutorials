# Host static website using Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-1"  # Singapore region
}

resource "aws_s3_bucket" "mywebapp-bucket" {    # Create S3 bucket
  bucket = "mywebapp-bucket-1234e3tewq"          # S3 bucket unique name
}

resource "aws_s3_bucket_public_access_block" "mywebapp-bucket-public-access" {  # S3 bucket public access
  bucket = aws_s3_bucket.mywebapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp-bucket-access-policy" {               # S3 bucket access policy
  bucket = aws_s3_bucket.mywebapp-bucket.id
  policy = jsonencode(                          # convert the code in json and apply in AWS S3
    {
      Version = "2012-10-17",
      Statement = [
        {
          Sid       = "PublicReadGetObject",
          Effect    = "Allow",
          Principal = "*",
          Action    =[
                "s3:GetObject"
                ],
          Resource  = "arn:aws:s3:::${aws_s3_bucket.mywebapp-bucket.id}/*"              # S3 bucket unique name
        }
      ]
    }
  )
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {             # S3 bucket website configuration
  bucket = aws_s3_bucket.mywebapp-bucket.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.mywebapp-bucket.bucket
  source = "./index.html"                       # collect txt file from root dir
  key    = "index.html"                         # upload txt file name
  content_type = "text/html"
}

resource "aws_s3_object" "styles_css" {
  bucket = aws_s3_bucket.mywebapp-bucket.bucket
  source = "./styles.css"                       # collect txt file from root dir
  key    = "styles.css"                         # upload txt file name
  content_type = "text/css"
}

output "name" {
  value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
}
