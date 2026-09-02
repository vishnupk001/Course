resource "aws_instance" "webserver" {

  ami                    = "ami-00d2dbb426772b03a"
  instance_type          = "t3.micro"
  key_name               = "vpk_devops"
  vpc_security_group_ids = [ "sg-0fa0cca3f81790e39" ]
  subnet_id = module.myvpc.subnet_public1_id
  tags = {
    Name        = "webserver"
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [ tags, vpc_security_group_ids ]
  }

}