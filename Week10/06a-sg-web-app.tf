resource "aws_security_group" "web_server" {
  name        = "web-server-sg"
  description = "Allow HTTP and SSH for web server"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "web-server-sg"
    tier = "web"
  }
}

resource "aws_vpc_security_group_ingress_rule" "web_server_http" {
  security_group_id            = aws_security_group.web_server.id
  description                  = "HTTP from alb"
  referenced_security_group_id = aws_security_group.web_lb.id
  from_port                    = 80
  ip_protocol                  = "tcp"
  to_port                      = 80
}

resource "aws_vpc_security_group_ingress_rule" "web_server_ssh" {
  security_group_id            = aws_security_group.web_server.id
  description                  = "HTTP from alb"
  referenced_security_group_id = aws_security_group.web_lb.id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

# outbound rule
resource "aws_vpc_security_group_egress_rule" "web_server_egress" {
  security_group_id = aws_security_group.web_server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}