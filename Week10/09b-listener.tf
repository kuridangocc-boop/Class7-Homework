resource "aws_lb_listener" "web_tier_http" {
  load_balancer_arn = aws_lb.web_tier.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web-tier.arn
  }
}