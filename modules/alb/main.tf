resource "aws_lb" "main" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.alb_security_groups
  subnets            = var.alb_subnets

  access_logs {
    bucket  = var.alb_log_bucket
    enabled = false
    prefix  = "logs/alb"
  }
}

resource "aws_lb_target_group" "main" {
  name        = "${var.alb_name}-tg"
  port        = var.enable_https ? 443 : 80
  protocol    = var.target_group_protocol
  vpc_id      = var.vpc_id
  target_type = "instance"
}

resource "aws_lb_listener" "http" {
  count             = var.enable_https ? 0 : 1
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"


  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

resource "aws_lb_listener" "https" {
  count             = var.enable_https ? 1 : 0
  load_balancer_arn = aws_lb.main.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}

