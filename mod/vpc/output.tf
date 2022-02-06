output "vpc" {
    value = aws_vpc.main_vpc
}

output "az_count" {
    value = "2"
}

output "environment" {
    value = var.environment
}

output "app_name" {
    value = "build-webpage-demo"
}
