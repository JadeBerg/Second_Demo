# In this directory i keep my modules

## I have 6 modules:

> `vpc` - this module creates vpc, where we create other resources

> `subnet` - this module creates network for our infrastructure

> `sg` - this module creates security group for access to load balancer therefore to instances

> `init` - this module creates local build of image and pushe it to ECR

> `ec2` - this module creates ECR, instances and iam role for them(Auto Scalling group, Launch configuration and IAM Role)

> `alb` - this module creates Load Balancer for our instances