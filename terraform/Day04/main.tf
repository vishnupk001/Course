resource "aws_key_pair" "authentication_key" {
  key_name   = "${var.project_name}-${var.project_environment}"
  public_key = file("mykey.pub")
  tags = {
    Name        = "${var.project_name}-${var.project_environment}"
  }
}


resource "aws_security_group" "webserver-access" {
  name        = "${var.project_name}-${var.project_environment}-webserver"
  description = "${var.project_name}-${var.project_environment}-webserver"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.project_environment}-webserver"
  }
}

resource "aws_security_group" "remote_access" {
  name        = "${var.project_name}-${var.project_environment}-remote"
  description = "${var.project_name}-${var.project_environment}-remote"

  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = "${var.project_name}-${var.project_environment}-remote"
  }
}

resource "aws_instance" "webserver" {

  ami                    = var.instance_ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.authentication_key.id
  vpc_security_group_ids = [aws_security_group.webserver-access.id, aws_security_group.remote_access.id ]
  user_data = file("setup.sh")
  tags = {
    Name        = "${var.project_name}-${var.project_environment}-webserver"
  }
}
