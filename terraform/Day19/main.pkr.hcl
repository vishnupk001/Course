source "amazon-ebs" "image" {
  region = var.region
  source ami = var.instarpe_ami
  instance_type = var.instance_type
  ssh username = "ec2-user"
  ami_name = local.image_name
  
  tags = {
    Name = local.image_name
    Project = var.project name
    Environment = var.project_environment
  }
}

build {
  sources = [ "source.amazon-ebs.image" ]
  provisioner "shell" {
    script = "./setup.sh"
    execute_command = "sudo {{.Path}}"
  }
}

### packer validate -var-file="values.pkrvars.hcl" .
### packer build -var-file="values.pkrvars.hcl" .