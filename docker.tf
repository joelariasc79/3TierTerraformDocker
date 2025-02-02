provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "database" {
  ami           = "ami-07d2649d67dbe8900"
  instance_type = "t2.micro"

  tags = {
    Name = "database"
  }
}

resource "aws_instance" "docker_back_end" {
  ami           = "ami-07d2649d67dbe8900"
  instance_type = "t2.micro"

  tags = {
    Name = "docker-back-end"
  }
}

resource "aws_instance" "docker_front_end" {
  ami           = "ami-07d2649d67dbe8900"
  instance_type = "t2.medium"

  tags = {
    Name = "docker-front-end"
  }
}

output "database_public_ip" {
  value = aws_instance.database.public_ip
}

output "docker_back_end_public_ip" {
  value = aws_instance.docker_back_end.public_ip
}

output "docker_front_end_public_ip" {
  value = aws_instance.docker_front_end.public_ip
}

