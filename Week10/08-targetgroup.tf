resource "aws_lb_target_group" "web-tier" {
  name     = "web-tier-server-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id

  tags = {
    Name = "web-tier-tg"
  }
}




