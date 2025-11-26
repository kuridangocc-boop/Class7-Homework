resource "aws_autoscaling_group" "demo-asg" {
  name             = "web-server-asg"
  min_size         = 1
  max_size         = 4
  desired_capacity = 3
  vpc_zone_identifier = [
    aws_subnet.private_a.id,
    aws_subnet.private_b.id,
    aws_subnet.private_c.id
  ]
  launch_template {
    id      = aws_launch_template.web_tier.id
    version = "$Latest"
  }
  health_check_type         = "ELB"
  health_check_grace_period = 300
  force_delete              = true
  target_group_arns         = [aws_lb_target_group.web-tier.arn]

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
  enabled_metrics = ["GroupMinSize", "GroupMaxSize", "GroupDesiredCapacity", "GroupInServiceInstances", "GroupTotalInstances"]
}