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

resource "aws_s3_bucket" "demo-bucket" {        # Create S3 bucket
  bucket = "demo-bucket-ab12vf34"               # S3 bucket unique name
}

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.demo-bucket.bucket
  source = "./index.txt"                       # collect txt file from root dir
  key    = "index.txt"                         # upload txt file name
}
