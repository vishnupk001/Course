output "instance_id" {

value = aws_instance.webserver.id

}

output "webserver_public_ip" {

value = aws_eip.webserver.public_ip

}

output "webserver_public_dns" {

value = aws_eip.webserver.public_dns

}

output "webserver_url" {

value = "http://${var.hostname}.${var.domain_name}"

}