module "network" {
  source   = "./modules/network"
  vpc_cidr = var.vpc_cidr
  vpc_name = var.vpc_name
  igw_name = var.igw_name
  rt_name  = var.rt_name
}

module "network_security" {
  source                           = "./modules/network_security"
  vpc_id                           = module.network.vpc_id
  project_id                       = var.project_id
  allowed_ip_range                 = var.allowed_ip_range
  ssh_security_group_name          = var.ssh_security_group_name
  public_http_security_group_name  = var.public_http_security_group_name
  private_http_security_group_name = var.private_http_security_group_name
}

module "application" {
  source                   = "./modules/application"
  project_id               = var.project_id
  vpc_id                   = module.network.vpc_id
  aws_launch_template_name = var.aws_launch_template_name
  sg_ssh_inbound_id        = module.network_security.sg_ssh_inbound_id
  sg_http_inbound_id       = module.network_security.sg_http_inbound_id
  sg_lb_http_inbound_id    = module.network_security.sg_lb_http_inbound_id
  aws_asg_name             = var.aws_asg_name
  load_balancer_name       = var.load_balancer_name
  public_subnet_id1        = tolist(module.network.public_subnet_ids)[0]
  public_subnet_id2        = tolist(module.network.public_subnet_ids)[1]
}