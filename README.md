# Second_Demo
# Main topic of this demo build a working infrastructure with terraform code

## In my version of demo i create such resources as:

### 1) VPC(It contains other resources)
### 1) Load Balancer(For balancing our instances)
### 2) Auto Scalling group and Launch configuration(For creating our instances)
### 3) Network for instances(Subnets, Route Tables, Internet Gateways, Nat Gateways, Elastic Ips)
### 4) Security group for our instances and load balancer
### 5) Elastic container registry for keeping our image(ECR)
### 5) Iam Role for giving access our instances to ECR(ReadOnly)
### 6) Null resource for local build our image and push to ECR