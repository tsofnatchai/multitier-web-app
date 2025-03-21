variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "vpc_cidr" {
   description = "CIDR block for the VPC"
   default     = "10.0.0.0/16"
  }

variable "alb_sg_cidr" {
  description = "CIDR block for ALB ingress"
  type        = string
  default     = "0.0.0.0/0"
}

variable "alb_access_logs_bucket" {
  description = "S3 bucket for ALB access logs"
  type        = string
  default     = "my-alb-logs"
}

variable "launch_template_name" {
  description = "Name of the ASG launch template"
  type        = string
  default     = "web-launch-template"
}

variable "image_id" {
  description = "AMI ID for EC2 instances (Amazon Linux 2 recommended)"
  type        = string
  default     = "ami-049682606efa7fe65"  # Example: Amazon Linux 2 in us-east-1
}

variable "instance_type" {
  description = "Instance type for ASG instances"
  type        = string
  default     = "t3.micro"
}

variable "db_name" {
  description = "RDS database name"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "RDS master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "RDS master password"
  type        = string
  default     = "ChangeMe123!"  # For demonstration only; use a secure password
}

variable "ec2_role_name" {
  description = "Name for the EC2 IAM role."
  type        = string
  default     = "example-ec2-role"
}

variable "ec2_policy_name" {
  description = "Name for the IAM policy granting S3 read access."
  type        = string
  default     = "example-ec2-policy"
}

variable "instance_profile_name" {
  description = "Name for the EC2 instance profile."
  type        = string
  default     = "example-instance-profile"
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket that EC2 instances will access."
  type        = string
  # Replace with your actual S3 bucket ARN, e.g.: "arn:aws:s3:::my-bucket"
  default     = "arn:aws:s3:::terraform-state-bucket-tsofnat"
}
variable "s3_bucket_name" {
  description = "The name of the S3 bucket."
  type        = string
  default     = "terraform-state-bucket-tsofnat"
}
variable "environment" {
  description = "The environment name (DEV, QA, PROD, etc.)"
  type        = string
  default     = "dev"
}