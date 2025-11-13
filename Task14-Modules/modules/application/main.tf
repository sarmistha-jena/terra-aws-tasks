resource "aws_launch_template" "aws_launch_template_lt" {

  name          = var.aws_launch_template_name
  instance_type = "t3.micro"
  image_id      = "ami-09e6f87a47903347c"

  #   iam_instance_profile {
  #     name = var.iam_instance_profile_name
  #   }

  network_interfaces {
    delete_on_termination = true
    security_groups       = [var.sg_ssh_inbound_id, var.sg_http_inbound_id]
  }
  #   key_name = var.ssh_key_name

  user_data = filebase64("${path.module}/startup.sh")

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

resource "aws_autoscaling_group" "asg" {
  name             = var.aws_asg_name
  desired_capacity = 2
  max_size         = 2
  min_size         = 2

  vpc_zone_identifier = [var.public_subnet_id1, var.public_subnet_id2]
  launch_template {
    id      = aws_launch_template.aws_launch_template_lt.id
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

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
  tags = {
    Terraform = true
    Project   = var.project_id
  }
}
resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
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

resource "aws_autoscaling_attachment" "alb_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = aws_lb_target_group.alb_target_group.arn
}

resource "aws_lb" "alb" {
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_lb_http_inbound_id]
  subnets            = [var.public_subnet_id1, var.public_subnet_id2]

  tags = {
    Terraform = true
    Project   = var.project_id
  }
}
