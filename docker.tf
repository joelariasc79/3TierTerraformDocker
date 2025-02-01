provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "docker_backEnd" {
  ami           = "ami-07d2649d67dbe8900"
  instance_type = "t2.micro"

  tags = {
    Name = "Docker-BackEnd"
  }
}

resource "aws_instance" "docker_backEnd" {
  ami           = "ami-07d2649d67dbe8900"
  instance_type = "t2.micro"

  tags = {
    Name = "Docker-BackEnd"
  }
}

resource "aws_instance" "docker_frontEnd" {
  ami           = "ami-07d2649d67dbe8900"
  instance_type = "t2.medium"

  tags = {
    Name = "Docker-FrontEnd"
  }
}

output "docker_backEnd_public_ip" {
  value = aws_instance.docker_backEnd.public_ip
}

output "docker_frontEnd_public_ip" {
  value = aws_instance.docker_frontEnd.public_ip
}

