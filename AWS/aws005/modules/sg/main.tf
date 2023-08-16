# create security group for the application load balancer
resource "aws_security_group" "alb_sg" {
  name        = "aws${var.project} alb security group"
  description = "Enable http/https access on port 80/443"
  vpc_id      = var.vpc_id

  ingress {
    description = "http access"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https access"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "ALB_SG"
  })
}

# Create App SG
resource "aws_security_group" "app_sg" {
  name        = "aws${var.project}_app_sg"
  description = "Enable http/https access on port 3000 from ALB sg"
  vpc_id      = var.vpc_id

  ingress {
    description     = "http access"
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge({
    Name = "aws${var.project}_app_sg"
  })
}