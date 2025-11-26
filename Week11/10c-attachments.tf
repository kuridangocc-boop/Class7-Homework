# Create a new ALB Target Group attachment
resource "aws_autoscaling_attachment" "web_tier" {
  autoscaling_group_name = aws_autoscaling_group.demo-asg.name
  lb_target_group_arn    = aws_lb_target_group.web-tier.id
}