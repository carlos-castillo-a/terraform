output "TG_ARN" {
  value = aws_lb_target_group.alb_target_group.arn
}

output "alb_domain_name" {
  value = aws_lb.application_load_balancer.dns_name
}