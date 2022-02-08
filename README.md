# Second_Demo
## Main topic of this demo: Build a working infrastructure with terraform code

### In my version of demo i create such resources as:

> 1) `VPC`(It contains other resources)
> 2) `Load Balancer`(For balancing our instances)
> 3) `Auto Scalling group` and `Launch configuration`(For creating our instances)
> 4) Network for instances(`Subnets`, `Route Tables`, `Internet Gateways`, `Nat Gateways`, `Elastic Ips`)
> 5) `Security group` for our instances and load balancer
> 6) `Elastic container registry` for keeping our image(ECR)
> 7) `Iam Role` for giving access our instances to ECR(ReadOnly)
> 8) `Null resource` for local build our image and push to ECR

### Description of files in main directory

> `main.tf` - my infrastructure creates with terraform modules in this file we describe our modules

> `var.tf` - in this file i keep region for my infrastructure, which i use in code very often

> `output.tf` - this file output the url to our load balancer for convenience

> `mod` - in this directory we have our modules for build our infrastructure

> `app_docker` - in this directory we have our application, Dockerfile and Makefile