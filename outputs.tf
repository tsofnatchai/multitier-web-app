output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = module.alb.alb_dns_name
}

output "rds_endpoint" {
  description = "Endpoint of the RDS MySQL instance"
  value       = module.rds.rds_endpoint
}
// outputs.tf - Root outputs

output "ec2_role_arn" {
  description = "The ARN of the EC2 IAM role from the security module."
  value       = module.iam.ec2_role_arn
}

output "instance_profile_name" {
  description = "The name of the EC2 instance profile from the security module."
  value       = module.iam.instance_profile_name
}
