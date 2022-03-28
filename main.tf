terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  required_version = "~>1.0"
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}


resource "aws_vpc" "main" {
    cidr_block       = "${var.main_vpc_cidr}"
    instance_tenancy = "default"

    tags = {
      Owner = "a.belov.n@gmail.com"
  }
}
resource "aws_subnet" "publicsubnets" {   
    vpc_id =  aws_vpc.main.id
    cidr_block = "${var.public_subnets}"

    tags = {
        Owner = "a.belov.n@gmail.com"
  }
}
                
resource "aws_subnet" "privatesubnets" {
    vpc_id =  aws_vpc.main.id
    cidr_block = "${var.private_subnets}"

    tags = {
        Owner = "a.belov.n@gmail.com"
  }
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Owner = "a.belov.n@gmail.com"
  }
}

