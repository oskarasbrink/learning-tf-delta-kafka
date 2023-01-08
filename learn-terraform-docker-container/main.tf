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
  vpc_security_group_ids = [aws_security_group.main.id]
  key_name = "best_key_again"
  tags = {
    Name = "ExampleAppServerInstance"
  }
  # file provisioner - 
  # It will copy the "startup.sh" to remote machine
  provisioner "file" {
    source      = "credentials/gh-ssh.pem"
    destination = "/home/ec2-user/cred/gh-ssh.pem"
  }

  provisioner "file" {
    source      = "startup.sh"
    destination = "/home/ec2-user/startup.sh"
  }
  provisioner "file" {
    source      = "docker-start.sh"
    destination = "/home/ec2-user/docker-start.sh"
  }
  provisioner "file" {
    source      = "cred/aws-credentials"
    destination = "/home/ec2-user/cred/aws-credentials.txt"
  }
  
  
# connection -
  # This block will be used for ssh connection to initiate the copy
  connection {
      type        = "ssh"
      host        = "${self.public_ip}"
      agent       = true
      user        = "ec2-user"
      private_key = file("~/.ssh/best_key_again.pem")
      timeout     = "10m"
   }
   provisioner "remote-exec" {
  inline = [
    "chmod +x /home/ec2-user/startup.sh",
    "chmod +x /home/ec2-user/docker-start.sh",
    "/home/ec2-user/startup.sh"
  ]
  }
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
 ingress                = [
   {
     cidr_blocks      = [ "0.0.0.0/0", ]
     description      = ""
     from_port        = 22
     ipv6_cidr_blocks = []
     prefix_list_ids  = []
     protocol         = "tcp"
     security_groups  = []
     self             = false
     to_port          = 22
  }
  ]
}

# aws_key_pair -
# You need to generate the public as well as private key using - ssh-keygen
# Place the public key here 
#resource "aws_key_pair" "deployer" {
#  key_name   = "best_key_again"
#  public_key = "key-0acfc3bc2f2b8e621"
#}

