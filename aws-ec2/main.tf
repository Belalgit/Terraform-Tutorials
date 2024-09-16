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

resource "aws_instance" "Test-srv" {
  ami                         = "ami-047b32292da23477b"  # Provided AMI
  instance_type               = "t4g.small"  # Instance type
  availability_zone           = "ap-southeast-1a"  # Availability Zone
  key_name                    = "Test-srv-Key"  # SSH key pair mention
  subnet_id                   = "subnet-0fea489ab890682e6"  # Subnet mention
  vpc_security_group_ids      = ["sg-0e65778d49d70824e"]  # Security Group mention
  associate_public_ip_address = true  # Assign Public IP

  tags = {
    Name = "Test-srv"  # EC2 instance tag
  }

  root_block_device {
    volume_size           = 20  # Storage size
    volume_type           = "gp3"  # Storage type
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true  # Ensure new instances are created before old ones are destroyed
  }
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.Test-srv.id
  allocation_id = "eipalloc-0ae3db1fbcf2600c5"  # Elastic IP Allocation ID
}
