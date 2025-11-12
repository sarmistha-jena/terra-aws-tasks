resource "aws_launch_template" "blue_aws_launch_template_lt" {

  name          = var.blue_aws_launch_template_name
  instance_type = "t3.micro"
  image_id      = "ami-09e6f87a47903347c"

  # iam_instance_profile {
  #   name = var.iam_instance_profile_name
  # }

  network_interfaces {
    delete_on_termination = true
    security_groups       = [data.aws_security_group.ssh_sg.id, data.aws_security_group.http_sg.id]
  }
  #key_name = var.ssh_key_name

  user_data = filebase64("${path.module}/start-blue.sh")

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Terraform = true
      Project   = var.project_id
    }
  }
  tags = {
    Terraform = true
    Project   = var.project_id
  }
}

resource "aws_launch_template" "green_aws_launch_template_lt" {

  name          = var.green_aws_launch_template_name
  instance_type = "t3.micro"
  image_id      = "ami-09e6f87a47903347c"

  # iam_instance_profile {
  #   name = var.iam_instance_profile_name
  # }

  network_interfaces {
    delete_on_termination = true
    security_groups       = [data.aws_security_group.ssh_sg.id, data.aws_security_group.http_sg.id]
  }
  #key_name = var.ssh_key_name

  user_data = filebase64("${path.module}/start-green.sh")

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "optional"
  }
  tag_specifications {
    resource_type = "instance"

    tags = {
      Terraform = true
      Project   = var.project_id
    }
  }
  tags = {
    Terraform = true
    Project   = var.project_id
  }
}

resource "aws_autoscaling_group" "blue_asg" {
  name             = var.blue_asg_name
  desired_capacity = 2
  max_size         = 2
  min_size         = 1

  vpc_zone_identifier = [data.aws_subnet.public_subnet_1.id, data.aws_subnet.public_subnet_2.id]
  launch_template {
    id      = aws_launch_template.blue_aws_launch_template_lt.id
    version = "$Latest"
  }
  # Add this lifecycle block to ignore changes to load_balancers and target_group_arns
  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns,
    ]
  }
  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }
  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group" "green_asg" {
  name             = var.green_asg_name
  desired_capacity = 2
  max_size         = 2
  min_size         = 1

  vpc_zone_identifier = [data.aws_subnet.public_subnet_1.id, data.aws_subnet.public_subnet_2.id]
  launch_template {
    id      = aws_launch_template.green_aws_launch_template_lt.id
    version = "$Latest"
  }
  # Add this lifecycle block to ignore changes to load_balancers and target_group_arns
  lifecycle {
    ignore_changes = [
      load_balancers,
      target_group_arns,
    ]
  }
  tag {
    key                 = "Terraform"
    value               = "true"
    propagate_at_launch = true
  }
  tag {
    key                 = "Project"
    value               = var.project_id
    propagate_at_launch = true
  }
}

resource "aws_lb_target_group" "blue_alb_target_group" {
  name     = var.blue_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected_vpc.id
  health_check {
    path     = "/"
    protocol = "HTTP"
    matcher  = "200-399"
  }
  tags = {
    Terraform = true
    Project   = var.project_id
  }
}

resource "aws_lb_target_group" "green_alb_target_group" {
  name     = var.green_tg_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.selected_vpc.id
  health_check {
    path     = "/"
    protocol = "HTTP"
    matcher  = "200-399"
  }
  tags = {
    Terraform = true
    Project   = var.project_id
  }
}

resource "aws_autoscaling_attachment" "blue_alb_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.blue_asg.name
  lb_target_group_arn    = aws_lb_target_group.blue_alb_target_group.arn
}

resource "aws_autoscaling_attachment" "green_alb_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.green_asg.name
  lb_target_group_arn    = aws_lb_target_group.green_alb_target_group.arn
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"

    forward {
      target_group {
        arn    = aws_lb_target_group.blue_alb_target_group.arn
        weight = var.blue_weight
      }
      target_group {
        arn    = aws_lb_target_group.green_alb_target_group.arn
        weight = var.green_weight
      }
    }
  }
  tags = {
    Terraform = true
    Project   = var.project_id
  }
}

resource "aws_lb" "alb" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.lb_http_sg.id]
  subnets            = [data.aws_subnet.public_subnet_1.id, data.aws_subnet.public_subnet_2.id]

  tags = {
    Terraform = true
    Project   = var.project_id
  }
}

data "aws_vpc" "selected_vpc" {
  #cidr_block = "10.0.0.0/16"
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

output "vpc_id" {
  value = data.aws_vpc.selected_vpc.id
}

data "aws_subnet" "public_subnet_1" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_name_1]
  }
}

data "aws_subnet" "public_subnet_2" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet_name_2]
  }
}

data "aws_security_group" "ssh_sg" {
  name = var.sg_ssh_inbound_id
}

data "aws_security_group" "http_sg" {
  name = var.sg_http_inbound_id
}

data "aws_security_group" "lb_http_sg" {
  name = var.sg_lb_http_inbound_id
}