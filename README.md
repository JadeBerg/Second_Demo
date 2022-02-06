# Second_Demo
# Main topic of this demo build a working infrastructure with terraform code

## In my version of demo i create such resources as:

> 1) `VPC`(It contains other resources)
> 2) `Load Balancer`(For balancing our instances)
> 3) `Auto Scalling grou`p and `Launch configuration`(For creating our instances)
> 4) Network for instances(`Subnets`, `Route Tables`, `Internet Gateways`, `Nat Gateways`, `Elastic Ips`)
> 5) `Security group` for our instances and load balancer
> 6) `Elastic container registry` for keeping our image(ECR)
> 7) `Iam Role` for giving access our instances to ECR(ReadOnly)
> 8) `Null resource` for local build our image and push to ECR