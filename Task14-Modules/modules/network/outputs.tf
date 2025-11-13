output "vpc_id" {
  description = "The unique identifier of the VPC."
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "A set of IDs for all public subnets."
  value       = toset([for s in aws_subnet.example_subnets : s.id])
}