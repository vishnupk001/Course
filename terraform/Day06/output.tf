output "webserver1_public_ip" {

value = aws_instance.webserver[0].public_ip
}

output "webserver2_public_ip" {

value = aws_instance.webserver[1].public_ip
}

output "webserver3_public_ip" {

value = aws_instance.webserver[2].public_ip
}