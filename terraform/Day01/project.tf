provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAYFYJGMJ4CEB3C3H4"
  secret_key = "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"
}

resource "aws_instance" "webserver" {

  ami                    = "ami-00d2dbb426772b03a"
  instance_type          = "t3.micro"
  key_name               = "vpk_devops"
  vpc_security_group_ids = ["sg-03c7e232616d0c054", "sg-0eda3ba39e9ab965b"]
  tags = {
    Name        = "food-app"
    Project     = "food"
    Environemnt = "production"
  }
}
