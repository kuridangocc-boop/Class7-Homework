
# for web server only 
resource "aws_security_group" "web_lb" {
  name        = "web-alb-sg"
  description = "Allow HTTP for web tier all"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "web-server-alb-sg"
    tier = "web"
  }
}

# inbound rule
resource "aws_vpc_security_group_ingress_rule" "http" {
  security_group_id = aws_security_group.web_lb.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  ip_protocol = "tcp"
  to_port     = 80
}

# outbound rule
resource "aws_vpc_security_group_egress_rule" "egress" {
  security_group_id = aws_security_group.web_lb.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
