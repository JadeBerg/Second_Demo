resource "aws_security_group" "SG_ALB_EC2" {
    name = "Security Group for EC2 and Load Balancer"
    vpc_id = var.vpc.id

      ingress {
        protocol    = "tcp"
        from_port   = var.app_port
        to_port     = var.app_port
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "${var.environment}-EC2-SG"
    }    
}