provider "aws" {
    region = var.region
}

module "vpc" {
    source = "./mod/vpc"
}

module "subnet" {
    source = "./mod/subnet"
    vpc = module.vpc.vpc
    environment = module.vpc.environment
    az_count = module.vpc.az_count
}

module "sg" {
    source = "./mod/sg"
    vpc = module.vpc.vpc
    environment = module.vpc.environment
}

module "alb" {
    source = "./mod/alb"
    vpc = module.vpc.vpc
    environment = module.vpc.environment
    app_name = module.vpc.app_name
    vpc_sg_ec2_ids = module.sg.vpc_sg_ec2_ids
    subnet_public_id = module.subnet.subnet_public_id
    app_port = module.sg.app_port
}

module "init" {
    source = "./mod/init"
    app_name = module.vpc.app_name
    region = var.region
    reg_id = module.ec2.reg_id
}

module "ec2" {
    source = "./mod/ec2"
    subnet_private_id = module.subnet.subnet_private_id
    vpc_sg_ec2_ids = module.sg.vpc_sg_ec2_ids
    az_count = module.vpc.az_count
    aws_alb_target_group = module.alb.aws_alb_target_group
    app_name = module.vpc.app_name
    image_tag = module.init.image_tag
    region = var.region
}