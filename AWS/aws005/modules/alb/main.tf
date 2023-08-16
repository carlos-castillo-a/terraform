# Create ALB
resource "aws_lb" "application_load_balancer" {
  name                       = "aws${var.project}-${var.environment}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_sg_id]
  subnets                    = [var.PUB_SUB_1_A_ID, var.PUB_SUB_2_B_ID]
  enable_deletion_protection = false

  tags = merge({
    Name = "aws${var.project}-${var.environment}-alb"
  })
}

# Create Target Group
resource "aws_lb_target_group" "alb_target_group" {
  name        = "aws${var.project}-${var.environment}-tg"
  target_type = "instance"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create Listeners
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 443
  protocol          = "HTTPS"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

