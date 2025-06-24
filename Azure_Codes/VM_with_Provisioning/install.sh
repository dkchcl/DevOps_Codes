#!/bin/bash
apt-get update -y
apt-get install -y nginx
echo "<h1>Welcome to Azure VM - NGINX provisioned by Terraform</h1>" > /var/www/html/index.html
systemctl enable nginx
systemctl start nginx