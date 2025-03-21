Advanced Terraform Exercise: Deploy a Scalable Multi-Tier Web Application on AWS
Objective
Design and implement a scalable, secure, and highly available multi-tier web application infrastructure on AWS using Terraform. This exercise will require you to apply advanced Terraform features and AWS services, including modules, remote state management, provisioners, and more.
________________________________________
Overview
You will build the following infrastructure:
●	Networking
○	A new VPC with public and private subnets spread across multiple Availability Zones (AZs).
○	Internet Gateway for internet access and NAT Gateways for outbound internet access from private subnets.
○	Properly configured route tables, security groups, and network ACLs.
●	Compute and Load Balancing
○	An Auto Scaling Group (ASG) of web servers (EC2 instances) in private subnets.
○	An Application Load Balancer (ALB) in public subnets to distribute traffic to the web servers.
●	Database
○	A RDS MySQL database instance in private subnets, inaccessible from the internet.
●	State Management and Modules
○	Use Terraform modules to organize your code.
○	Store Terraform state remotely in an S3 bucket with state locking using DynamoDB.
●	Advanced Terraform Features
○	Implement provisioners to bootstrap EC2 instances.
○	Utilize data sources to fetch dynamic information.
○	Apply variables, outputs, interpolation, conditionals, and loops.
________________________________________
Instructions
1. Setup Remote State Management
●	S3 Bucket for State Storage
○	Create an S3 bucket to store your Terraform state files.
○	Enable versioning on the bucket for state file history.
●	DynamoDB Table for State Locking
○	Create a DynamoDB table to enable state locking and prevent concurrent state modifications.
●	Backend Configuration
○	Configure your Terraform backend to use the S3 bucket and DynamoDB table.
2. VPC and Networking
●	VPC Creation
○	Create a VPC with a CIDR block of 10.0.0.0/16.
●	Subnets
○	Create at least two public subnets and two private subnets across two AZs.
○	Tag subnets appropriately (e.g., public-1, private-1).
●	Internet Gateway and NAT Gateways
○	Attach an Internet Gateway to the VPC.
○	Deploy NAT Gateways in each public subnet for redundancy.
●	Route Tables
○	Create and associate route tables for public and private subnets.
■	Public subnets route to the Internet Gateway.
■	Private subnets route to the NAT Gateways.
●	Security Groups and Network ACLs
○	Define Security Groups for the ALB, EC2 instances, and RDS.
■	ALB SG: Allows inbound HTTP/HTTPS traffic.
■	EC2 SG: Allows inbound traffic from ALB SG on HTTP/HTTPS ports.
■	RDS SG: Allows inbound traffic from EC2 SG on MySQL port.
○	Configure Network ACLs to add an additional layer of security.
3. Application Load Balancer (ALB)
●	Deployment
○	Create an ALB in the public subnets.
○	Configure listeners for HTTP (port 80) and HTTPS (port 443).
○	Set up appropriate target groups.
4. Auto Scaling Group (ASG) and Launch Configuration
●	Launch Configuration/Template
○	Use the latest Amazon Linux 2 AMI (use a data source to fetch).
○	Install Nginx and deploy a simple web application using user data scripts or provisioners.
●	Auto Scaling Group
○	Create an ASG using the launch configuration/template.
○	Configure the ASG to span the private subnets across both AZs.
○	Set desired, minimum, and maximum capacity.
○	Implement scaling policies based on CPU utilization.
5. RDS MySQL Database
●	Deployment
○	Launch an RDS MySQL instance in the private subnets.
○	Use Multi-AZ deployment for high availability.
○	Apply encryption at rest.
○	Configure parameter groups as needed.
●	Connectivity
○	Ensure the database is only accessible from the EC2 instances (correct Security Group setup).
6. IAM Roles and Policies
●	EC2 Instance Profile
○	Create an IAM role and attach it to your EC2 instances.
○	Grant least-privilege permissions, e.g., read access to specific S3 buckets if needed.
●	S3 Bucket Policies
○	If your EC2 instances need to access S3, set up appropriate bucket policies.
7. Terraform Modules
●	Module Structure
○	Organize your Terraform code into reusable modules:
■	vpc
■	alb
■	asg
■	rds
■	security
●	Module Usage
○	Each module should be in its own directory with its own main.tf, variables.tf, and outputs.tf.
8. Variables and Outputs
●	Variables
○	Externalize configurable parameters using variables.
■	Examples: instance types, key pair names, desired capacity.
●	Outputs
○	Output essential information like ALB DNS name, RDS endpoint, etc.
9. Provisioners and User Data
●	Bootstrapping EC2 Instances
○	Use provisioners or user data scripts to:
■	Install necessary software (e.g., Nginx, application dependencies).
■	Deploy application code from a repository or S3 bucket.
●	Templates
○	Use Terraform templates (.tpl files) to manage complex scripts.
10. Advanced Features
●	Conditionals and Loops
○	Use count, for_each, or dynamic blocks where appropriate.
■	Example: Create resources per AZ using loops.
●	Data Sources
○	Utilize data sources to fetch AMIs, VPCs, or other resources dynamically.
●	Interpolation and Functions
○	Implement Terraform interpolation and built-in functions to manage resource attributes.
●	Resource Tagging
○	Tag all AWS resources according to a consistent tagging strategy.
11. Documentation and Cleanup
●	README.md
○	Provide a comprehensive README explaining:
■	Architecture diagram or description.
■	How to initialize and deploy the infrastructure.
■	Variables that need to be set.
■	Any prerequisites or dependencies.
●	Cleanup Instructions
○	Ensure your Terraform configuration can cleanly destroy all created resources.
○	Provide any additional steps needed to avoid orphaned resources or charges.
________________________________________
Deliverables
1.	Terraform Codebase
○	Well-organized code using modules.
○	Properly commented and formatted code.
2.	Documentation
○	A detailed README.md file.
3.	Demonstration
○	Steps to initialize, plan, and apply the Terraform configuration.
○	Verification of deployed resources.
4.	Cleanup
○	Instructions or scripts to destroy all infrastructure.
________________________________________
Requirements and Constraints
●	Terraform Version
○	Use Terraform version >= 0.12.
●	AWS Account
○	You will need access to an AWS account with permissions to create the above resources.
○	Be mindful of AWS costs; use free-tier eligible resources where possible.
●	Security Best Practices
○	Do not hardcode sensitive information (use variables or AWS Secrets Manager).
○	Apply the principle of least privilege in IAM policies.
○	Ensure no public access to private resources (EC2 instances, RDS).
●	Code Quality
○	Follow Terraform best practices.
○	Use .gitignore to exclude sensitive files if using version control.
________________________________________
Additional Challenges (Optional)
●	SSL Termination
○	Configure SSL certificates for the ALB using AWS Certificate Manager.
●	Bastion Host
○	Implement a bastion host in the public subnet to allow SSH access to EC2 instances in private subnets.
●	Monitoring and Logging
○	Set up CloudWatch metrics and alarms for critical resources.
○	Enable logging for ALB and store logs in S3.
●	Automated Testing
○	Use Terraform testing tools like terratest to write automated tests for your infrastructure.
●	CI/CD Integration
○	Integrate your Terraform deployment with a CI/CD pipeline using tools like Jenkins or GitHub Actions.
________________________________________
Hints and Tips
●	Resource Naming
○	Use meaningful names and consider naming conventions for resources.
●	State Management
○	Be cautious with state files; always back up before major changes.
●	Debugging
○	Use terraform plan and terraform apply with the -var-file option to manage different environments.
●	Version Control
○	Commit your code changes incrementally and use meaningful commit messages.
________________________________________
Estimated Time to Complete
This exercise is comprehensive and may take 6-8 hours to complete, depending on your familiarity with Terraform and AWS services.
________________________________________
Getting Started
1.	Prepare Your Environment
○	Install the required Terraform version.
○	Configure AWS CLI with your credentials.
2.	Plan Your Approach
○	Sketch the architecture.
○	Decide on module structure and resource dependencies.
3.	Incremental Development
○	Develop and test each module individually before integrating.
4.	Testing
○	Regularly use terraform validate and terraform fmt.
○	Deploy in a test environment before applying to production (if applicable).


Prerequisite:

on AWS CLI:

I created S3 bucket in AWS:
aws s3api create-bucket --bucket terraform-state-bucket-tsofnat --region us-east-1
and added it permission->policy:
{
"Version": "2012-10-17",
"Statement": [
{
"Sid": "AllowELBAccessLogs",
"Effect": "Allow",
"Principal": {
"Service": "elasticloadbalancing.amazonaws.com"
},
"Action": [
"s3:ListBucket",
"s3:GetObject",
"s3:PutObject"
],
"Resource": [
"arn:aws:s3:::terraform-state-bucket-tsofnat",
"arn:aws:s3:::terraform-state-bucket-tsofnat/*"
]
}
]
}

create dynamo db table in AWS:
aws dynamodb create-table --table-name terraform-locking-user-tsofnat --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

terraform_aws_app/
│
├── modules/                     # Contains reusable Terraform modules
│   ├── alb/                     # Application Load Balancer (ALB) module
│   │   ├── main.tf              # ALB resource definition
│   │   ├── variables.tf         # ALB module variables
│   │   ├── outputs.tf           # ALB module outputs
│   │
│   ├── asg/                     # Auto Scaling Group (ASG) module
│   │   ├── main.tf              # ASG resource definition
│   │   ├── variables.tf         # ASG module variables
│   │   ├── outputs.tf           # ASG module outputs
│   │
│   ├── rds/                     # RDS MySQL module
│   │   ├── main.tf              # RDS resource definition
│   │   ├── variables.tf         # RDS module variables
│   │   ├── outputs.tf           # RDS module outputs
│   │
│   ├── security/                # Security group and IAM module
│   │   ├── main.tf              # Security groups, IAM roles and policies
│   │   ├── variables.tf         # Security module variables
│   │   ├── outputs.tf           # Security module outputs
│   │
│   └── vpc/                     # VPC networking module
│       ├── main.tf              # VPC and subnet resources
│       ├── variables.tf         # VPC module variables
│       ├── outputs.tf           # VPC module outputs
│
├── main.tf                      # Root module to tie everything together
├── variables.tf                 # Root variables for the project
├── outputs.tf                   # Root outputs for the project
├── terraform.tfvars             # Variable values for the root module
├── provider.tf                  # Provider configuration (AWS)
├── backend.tf                   # Backend configuration (S3, DynamoDB for state)
├── README.md                    # Project documentation
└── .gitignore                   # Git ignore file (e.g., for Terraform state files)

Outputs:

alb_dns_name = "multitier-app-alb-1212916596.us-east-1.elb.amazonaws.com"
ec2_role_arn = "arn:aws:iam::741448960679:role/example-ec2-role"
instance_profile_name = "example-instance-profile"
rds_endpoint = "mysql-db.curs4g4yygzv.us-east-1.rds.amazonaws.com:3306"
vpc_id = "vpc-057383770a50f453e"


Order of Creation and How Outputs/Variables Are Used
Remote State Setup:
– Create the S3 bucket and DynamoDB table (manually via the AWS Console/CLI or via a separate Terraform project) before running Terraform.
– The backend configuration in backend.tf tells Terraform where to store state and lock it.

Networking (VPC Module):
– The VPC module is invoked first. It creates the VPC, public subnets, and private subnets.
– Its outputs (e.g. vpc_id, public_subnets, private_subnets) are then used as inputs in other modules.

Security Module:
– The security module creates security groups for the ALB and RDS.
– Its output (alb_sg_id and rds_sg_ids) is referenced in the ALB and RDS modules respectively.

IAM Module:
– The IAM module creates an EC2 role (with least-privilege permissions such as S3 read access) and an instance profile.
– The instance profile name is passed as an input to the ASG module so that launched instances assume that role.

ALB Module:
– The ALB module is deployed next. It uses the public subnets (from VPC outputs) and the ALB security group from the security module.
– It creates the ALB and a target group. Its outputs (such as the ALB DNS name and target group ARN) are used by the ASG module.

ASG Module:
– The ASG module creates a launch template (or configuration) and an Auto Scaling Group in private subnets.
– It uses the ALB target group ARN, the instance profile from the IAM module, and the private subnets from the VPC module.

RDS Module:
– Finally, the RDS module deploys a Multi-AZ MySQL database in the private subnets.
– It uses security groups from the security module and private subnets from the VPC module. Its output (the RDS endpoint) is available for use by applications.

Root Outputs:
– The root outputs (e.g. VPC ID, ALB DNS name, RDS endpoint) provide essential information for accessing or integrating with the deployed infrastructure.
