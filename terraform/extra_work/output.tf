output "elb_dns_name" {
  value       = aws_elb.clb.dns_name
  description = "The public DNS name of the Classic Load Balancer"
}