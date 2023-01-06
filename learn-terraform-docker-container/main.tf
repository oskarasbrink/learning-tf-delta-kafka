terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  # Github web is awesome
  required_version = ">= 1.2.0"
}

provider "aws" {
  shared_credentials_files = ["${path.module}/credentials/aws-credentials"]
  profile                 = "default"
  region                  = "eu-west-1"
}



resource "aws_instance" "ec2_instance" {
  # standard AMI for eu-west-1
  # https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html#finding-quick-start-ami
  ami           = var.ami
  instance_type = var.instance_type
  iam_instance_profile = aws_iam_instance_profile.prototype-profile.name

  tags = {
    Name = "ExampleAppServerInstance"
  }
}
