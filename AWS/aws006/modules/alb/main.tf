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

# Create Users Target Group
resource "aws_lb_target_group" "users_target_group" {
  name        = "aws${var.project}-${var.environment}-users-tg"
  target_type = "ip"
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

# Create Threads Target Group
resource "aws_lb_target_group" "threads_target_group" {
  name        = "aws${var.project}-${var.environment}-threads-tg"
  target_type = "ip"
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

# Create Posts Target Group
resource "aws_lb_target_group" "posts_target_group" {
  name        = "aws${var.project}-${var.environment}-posts-tg"
  target_type = "ip"
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
  certificate_arn  = var.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

# Create Listener Rules for Users
resource "aws_lb_listener_rule" "users_listener_rule_http" {
  listener_arn = aws_lb_listener.alb_http_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.users_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/api/users*"]
    }
  }
}

resource "aws_lb_listener_rule" "users_listener_rule_https" {
  listener_arn = aws_lb_listener.alb_https_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.users_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/api/users*"]
    }
  }
}

# Create Listener Rules for Threads
resource "aws_lb_listener_rule" "threads_listener_rule_http" {
  listener_arn = aws_lb_listener.alb_http_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.threads_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/api/threads*"]
    }
  }
}

resource "aws_lb_listener_rule" "threads_listener_rule_https" {
  listener_arn = aws_lb_listener.alb_https_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.threads_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/api/threads*"]
    }
  }
}

# Create Listener Rules for Posts
resource "aws_lb_listener_rule" "posts_listener_rule_http" {
  listener_arn = aws_lb_listener.alb_http_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.posts_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/api/posts*"]
    }
  }
}

resource "aws_lb_listener_rule" "posts_listener_rule_https" {
  listener_arn = aws_lb_listener.alb_https_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.posts_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/api/posts*"]
    }
  }
}
