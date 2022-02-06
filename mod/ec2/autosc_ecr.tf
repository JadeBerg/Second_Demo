# Data for create ec2 instances
data "aws_ami" "latest_amazon_linux" {
    owners = ["amazon"]
    most_recent = true

    # Filter for searching ami
    filter{
        name = "name"
        values = ["amzn2-ami-kernel-5.10-hvm-*-x86_64-gp2"]
    }
}

# Create Repo for our docker image
resource "aws_ecr_repository" "ecr_repository" {
  name = var.app_name
}

# Create iam_instance_profile for our ec2 instances
resource "aws_iam_instance_profile" "Ecr_profile" {
  name = "Ecr_profile"
  role = "${aws_iam_role.EcrReadOnly.name}"
}

# Launch config for our autoscalling_group
resource "aws_launch_configuration" "launch" {
    depends_on  = [var.vpc_sg_ec2_ids]
    name = "launch"
    iam_instance_profile = "${aws_iam_instance_profile.Ecr_profile.name}"
    image_id = data.aws_ami.latest_amazon_linux.id
    security_groups = [var.vpc_sg_ec2_ids.id]
    instance_type = var.instance_type

    # User data for instances
    user_data = templatefile("./mod/ec2/start.tpl", {
      r_url = aws_ecr_repository.ecr_repository.repository_url
      image_tag = var.image_tag
      region = var.region
      reg_id = aws_ecr_repository.ecr_repository.registry_id
    })

    lifecycle {
      create_before_destroy = true
    }
}

# Create our instances with autoscalling_group
resource "aws_autoscaling_group" "app" { 
  depends_on                = [aws_launch_configuration.launch]
  name                      = "auto-asg"
  desired_capacity          = 2
  max_size                  = 2
  min_size                  = 2
  health_check_type         = "ELB"
  launch_configuration      = aws_launch_configuration.launch.name
  vpc_zone_identifier       = [for subnet in var.subnet_private_id : subnet]
  target_group_arns         = [var.aws_alb_target_group.arn]

  tag {
    key                 = "Name"
    value               = "${var.app_name}-ec2"
    propagate_at_launch = true
  }
}

# Do attachment to Load Balancer
resource "aws_autoscaling_attachment" "name" {
  autoscaling_group_name = aws_autoscaling_group.app.name
  alb_target_group_arn  =  var.aws_alb_target_group.arn
}