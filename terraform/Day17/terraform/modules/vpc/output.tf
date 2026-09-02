output  "vpc_id" {

value = aws_vpc.main.id

}

output "subnet_public1_id" {

value = aws_subnet.public_subnet[0].id

}

output "subnet_public2_id" {

value = aws_subnet.public_subnet[1].id

}

output "subnet_public3_id" {

value = aws_subnet.public_subnet[2].id

}

output "subnet_private1_id" {

value = aws_subnet.private_subnet[0].id

}

output "subnet_private2_id" {

value = aws_subnet.private_subnet[1].id

}

output "subnet_private3_id" {

value = aws_subnet.private_subnet[2].id

}