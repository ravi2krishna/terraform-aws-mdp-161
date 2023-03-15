# NACL
resource "aws_network_acl" "lms-nacl" {
  vpc_id = aws_vpc.lms.id
  tags = {
    Name = "lms-nacl"
  }
}
