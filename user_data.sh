#!/bin/bash
# Update system packages to ensure latest security patches
apt-get update -y
apt-get upgrade -y

# Install Nginx web server
apt-get install nginx -y

# Enable and start the service to ensure resilience on boot
systemctl start nginx
systemctl enable nginx