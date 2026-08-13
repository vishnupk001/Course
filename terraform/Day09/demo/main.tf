resource "aws_security_group" "webserver-access" {
  name        = "${var.project_name}-${var.project_environment}-webserver"
  description = "${var.project_name}-${var.project_environment}-webserver"
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.project_name}-${var.project_environment}-webserver"
  }
}

resource "aws_security_group_rule" "webserver-http" {

  count             = length(var.webserver_ingress_port) 

  type              = "ingress"
  from_port         = var.webserver_ingress_port[count.index]
  to_port           = var.webserver_ingress_port[count.index]
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.webserver-access.id
}

