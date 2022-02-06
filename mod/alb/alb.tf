# Create Load Balancer
resource "aws_alb" "main" {
    name = "${var.app_name}-${var.environment}-LB"
    subnets = [for subnet in var.subnet_public_id : subnet]
    security_groups = [var.vpc_sg_ec2_ids.id]
    load_balancer_type = "application"
}

# Create target group for Load Balancer
resource "aws_alb_target_group" "app" {
    name = "${var.app_name}-${var.environment}-tg"
    port = var.app_port
    protocol = "HTTP"
    vpc_id = var.vpc.id

    # Default helth checks
    health_check {
        healthy_threshold   = "3"
        interval            = "30"
        protocol            = "HTTP"
        matcher             = "200"
        timeout             = "3"
        unhealthy_threshold = "2"
    }
}

# Connect listener to target group
resource "aws_alb_listener" "front" {
    load_balancer_arn = aws_alb.main.arn
    port = var.app_port
    
    # Action for listener
    default_action {
        target_group_arn = aws_alb_target_group.app.arn
        type = "forward" 
    }
}