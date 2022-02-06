#!/bin/bash
sudo yum update -y
sudo amazon-linux-extras install docker -y
sudo service docker start
aws ecr get-login-password --region ${region} | docker login --username AWS --password-stdin ${reg_id}.dkr.ecr.${region}.amazonaws.com
sudo docker pull ${r_url}:${image_tag}
sudo docker run -p 80:80 --name app -d ${r_url}:${image_tag}