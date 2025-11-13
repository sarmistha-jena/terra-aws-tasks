project_id = "cmtr-959pompn"

allowed_ip_range = ["18.153.146.156/32", "49.36.109.6/32"]

vpc_cidr = "10.10.0.0/16"
vpc_name = "cmtr-959pompn-vpc"
igw_name = "cmtr-959pompn-igw"
rt_name  = "cmtr-959pompn-rt"
# public_subnet_name  = "cmtr-959pompn-public-subnet"
# private_subnet_name = "cmtr-959pompn-private-subnet"

# # Security group names (optional overrides)
ssh_security_group_name          = "cmtr-959pompn-ssh-sg"
public_http_security_group_name  = "cmtr-959pompn-public-http-sg"
private_http_security_group_name = "cmtr-959pompn-private-http-sg"
# private_instance_id              = "i-00eeeed2c193a9f12"
# public_instance_id               = "i-0557eb091e0de1ea0"

# #Data source variable values
# aws_region   = "us-east-1"
# state_bucket = "cmtr-959pompn-tf-state-1762785779"
# state_key    = "infra.tfstate"

#ALB
# vpc_name = "cmtr-959pompn-vpc"
# public_subnet_id1 = "subnet-014258dc6a3d99b60"
# public_subnet_id2 = "subnet-0786451f1f0dd1092"
# public_subnet_name_1 = "cmtr-959pompn-public-subnet1"
# public_subnet_name_2 = "cmtr-959pompn-public-subnet2"
aws_launch_template_name = "cmtr-959pompn-template"
#iam_instance_profile_name = "cmtr-959pompn-instance_profile"
# sg_ssh_inbound_id     = "cmtr-959pompn-sg-ssh"
# sg_http_inbound_id    = "cmtr-959pompn-sg-http"
# sg_lb_http_inbound_id = "cmtr-959pompn-sg-lb"
#ssh_key_name          = "cmtr-959pompn-keypair"
aws_asg_name       = "cmtr-959pompn-asg"
load_balancer_name = "cmtr-959pompn-lb"
# blue_aws_launch_template_name  = "cmtr-959pompn-blue-template"
# green_aws_launch_template_name = "cmtr-959pompn-green-template"
# blue_asg_name                  = "cmtr-959pompn-blue-asg"
# green_asg_name                 = "cmtr-959pompn-green-asg"
# blue_tg_name                   = "cmtr-959pompn-blue-tg"
# green_tg_name                  = "cmtr-959pompn-green-tg"