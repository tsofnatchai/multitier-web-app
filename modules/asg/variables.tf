variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnets" {
  description = "List of private subnet IDs for the ASG"
  type        = list(string)
}

variable "launch_template_name" {
  description = "Name of the launch template"
  type        = string
}

variable "image_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach to the instances"
  type        = list(string)
}

variable "alb_target_group" {
  description = "ARN of the ALB target group"
  type        = string
}
