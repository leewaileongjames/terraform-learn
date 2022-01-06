#!/bin/bash

sudo yum update -y && sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker ec2-user
newgrp docker
docker run -p 5000:80 httpd
