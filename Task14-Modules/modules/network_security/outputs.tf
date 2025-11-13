output "sg_ssh_inbound_id" {
  description = "SSH security group id"
  value       = aws_security_group.ssh_sg.id
}

output "sg_http_inbound_id" {
  description = "Private HTTP security group id"
  value       = aws_security_group.private_http_sg.id
}

output "sg_lb_http_inbound_id" {
  description = "Public HTTP security group id"
  value       = aws_security_group.public_http_sg.id
}