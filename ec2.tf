# AWS EC2 Instance 
resource "aws_instance" "lms-web-server" {
  ami                    = "ami-0f8ca728008ff5af4"
  instance_type          = "t2.micro"
  key_name               = "ravi"
  subnet_id              = aws_subnet.lms-subnet.id
  vpc_security_group_ids = [aws_security_group.lms-web-sg.id]
  user_data              = file("web.sh")
  tags = {
    Name = "lms web server"
  }
}