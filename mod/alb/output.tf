output "alb-host" {
    value = aws_alb.main.dns_name
}

output "aws_alb_target_group" {
    value = aws_alb_target_group.app
}