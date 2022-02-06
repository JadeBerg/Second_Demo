variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "subnet_private_id" {}

variable "vpc_sg_ec2_ids" {}

variable "az_count" {}

variable "aws_alb_target_group" {}

variable "app_name" {}

variable "image_tag" {}

variable "region" {}