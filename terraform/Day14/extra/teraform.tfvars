aws_region="ap-south-1"
project_name="zomato"
project_environment="production"
vpc_cidr_block = "172.20.0.0/16"
enable_natgw=true
loadbalancer_ingress_ports = ["80","443"]
debug_backend = true
bastion_instance_type = "t3.micro"
bastion_ami_id = "ami-00d2dbb426772b03a"
backend_instance_type = "t3.micro"
domain_name="vpkdevops.online"
hostname="webapp"


asg_capacity = {
  min_size         = 1
  max_size         = 2
  desired_capacity = 2
}

target_group ={
  port                   = 80
  deregistration_delay   = 10
  target_type            = "instance"
  path                   =  "/health.html"
  interval               = 30
  timeout                = 2
  healthy_threshold      = 2
  unhealthy_threshold.   = 2
  protocol               = "HTTP"
}

