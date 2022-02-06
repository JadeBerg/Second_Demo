output "vpc_sg_ec2_ids" {
    value = aws_security_group.SG_ALB_EC2
}

output "app_port" {
    value = var.app_port
}