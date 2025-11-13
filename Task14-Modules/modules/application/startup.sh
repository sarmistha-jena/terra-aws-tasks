#!/bin/bash

# Update system packages
yum update -y

# Install necessary utilities and components
yum install -y aws-cli httpd jq

# Enable and start the web server
systemctl enable httpd
systemctl start httpd

mkdir -p /var/www/html

# Retrieve IMDSv2 token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Retrieve instance metadata using the token
COMPUTE_INSTANCE_ID=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/instance-id)
PRIVATE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/local-ipv4)
COMPUTE_MACHINE_UUID=$(cat /sys/devices/virtual/dmi/id/product_uuid |tr '[:upper:]' '[:lower:]')
# Create the simple HTML web page
echo "This message was generated on instance $COMPUTE_INSTANCE_ID with the following UUID $COMPUTE_MACHINE_UUID" > /var/www/html/index.html