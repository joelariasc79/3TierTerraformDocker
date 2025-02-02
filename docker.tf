variable "public_key" {
  description = "The public key to use for SSH access"
  type        = string
}

provider "aws" {
  region = "us-west-1"
}


resource "aws_key_pair" "my_key" {
  key_name   = "my-key-pair"
  public_key = var.public_key
}

resource "aws_instance" "database" {
  ami           = "ami-07d2649d67dbe8900"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name

  tags = {
    Name = "database"
  }

  vpc_security_group_ids = [aws_security_group.database_sg.id]
}

resource "aws_security_group" "database_sg" {
  name        = "database-sg"
  description = "Security group for database instance"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "docker_back_end" {
  ami           = "ami-07d2649d67dbe8900"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name

  tags = {
    Name = "docker-back-end"
  }

  vpc_security_group_ids = [aws_security_group.docker_back_end_sg.id]
}

resource "aws_security_group" "docker_back_end_sg" {
  name        = "docker-back-end-sg"
  description = "Security group for docker backend instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8081
    to_port     = 8081
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "docker_front_end" {
  ami           = "ami-07d2649d67dbe8900"
  instance_type = "t2.medium"
  key_name      = aws_key_pair.my_key.key_name

  tags = {
    Name = "docker-front-end"
  }

  vpc_security_group_ids = [aws_security_group.docker_front_end_sg.id]
}


resource "aws_security_group" "docker_front_end_sg" {
  name        = "docker-front-end-sg"
  description = "Security group for docker frontend instance"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 4200
    to_port     = 4200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
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

