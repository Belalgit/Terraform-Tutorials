terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {                        # remote tfstate file sent
  bucket = "demo-bucket-154q45"         # S3 bucket mention
  key    = "backend.tfstate"            # tfstate file
  region = "ap-southeast-1"
  }
}


provider "aws" {
  region = "ap-southeast-1"              # Singapore region
}

resource "aws_instance" "Test-srv" {
  ami                         = "ami-047b32292da23477b"  # Provided AMI
  instance_type               = "t4g.small"  # Instance type
  
  tags = {
    Name = "Test-srv"  # EC2 instance tag
  }
}
