output "webserver_url" {

  value = "http://${var.hostname} ${var.domain_name}"
}

output "webserver_public_ip" {

value = aws_eip.webserver.public_ip

}