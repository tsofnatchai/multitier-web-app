module "asg" {
  source  = "terraform-aws-modules/autoscaling/aws"

  name               = "web-asg"
  min_size           = 1
  max_size           = 3
  desired_capacity   = 1

  vpc_zone_identifier = var.private_subnets

  # Launch template configuration
  launch_template_name = var.launch_template_name
  image_id             = var.image_id
  instance_type        = var.instance_type

  user_data = base64encode(<<-EOF
  #!/bin/bash
  yum update -y
  amazon-linux-extras install nginx1 -y
  systemctl enable nginx
  systemctl start nginx
EOF
  )

  # Security groups for the instances
  security_groups = var.security_group_ids

  target_group_arns = [var.alb_target_group]
}
