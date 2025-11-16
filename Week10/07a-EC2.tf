# resource "aws_instance" "Hardbody-ec2" {
#   ami           = "ami-0cae6d6fe6048ca2c" # us-east-1
#   instance_type = "t3.micro"
#   #key_name =
#   vpc_security_group_ids = [aws_security_group.web_server.id]
#   subnet_id              = aws_subnet.private_a.id

#   associate_public_ip_address = true # unsure if this is needed, if subnet has auto assign public IP enabled




#   user_data = file("Hardbody.sh")

#   tags = {
#     Name = "Hardbody-ec2"
#   }
# }