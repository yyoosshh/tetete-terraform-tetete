provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_security_group" "this" {
  name = "first-security-group"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allow SSH from anywhere <- dangerous
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # Allow all traffic to anywhere <- dangerous
  }
}

resource "aws_instance" "this" {
  ami           = "ami-0a9e614c3d1eaa27d"
  instance_type = "t4g.micro"
  vpc_security_group_ids = [aws_security_group.this.id]
  user_data     = file("./user_data.sh")
  
  tags = {
    Name = "first-instance"
  }
}

output "public_dns" {
  value = aws_instance.this.public_dns
}
