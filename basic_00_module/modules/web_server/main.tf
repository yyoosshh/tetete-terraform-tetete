variable "instance_type" {}


resource "aws_instance" "default" {
  ami           = "ami-0a9e614c3d1eaa27d"
  instance_type = var.instance_type
  user_data     = file("./modules/web_server/user_data.sh")
}


resource "aws_security_group" "default" {
  name = "ec2-web-server"

  ingress {
    from_port   = 80
    to_port     = 80
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

output "public_dns" {
  value = aws_instance.default.public_dns
}
