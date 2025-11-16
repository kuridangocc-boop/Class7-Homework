resource "aws_launch_template" "web_tier" {
  description            = "launch template for web tier servers"
  image_id               = "ami-0cae6d6fe6048ca2c"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.web_server.id]
  tags = {
    name = "web-tier-server-template"
  }
  user_data = filebase64("Hardbody.sh") # need to make "file" to "filebase64"

  tag_specifications {
    resource_type = "instance"
    tags = {
      ManagedBy = "Terraform"
    }
  }
  lifecycle {
    create_before_destroy = true
  }

}

