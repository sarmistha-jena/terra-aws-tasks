#!/bin/bash

# Update system packages
yum update -y

# Install necessary utilities and components
yum install -y aws-cli httpd jq

# Enable and start the web server
systemctl enable httpd
systemctl start httpd

# Retrieve IMDSv2 token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Retrieve instance metadata using the token
INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)

# Create the simple HTML web page
echo -e "<h1>Blue Environment</h1>\nThis message was generated on instance $INSTANCE_ID with the following IP: $PRIVATE_IP" > /var/www/html/index.html
