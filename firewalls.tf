# NACL
resource "aws_network_acl" "lms-nacl" {
  vpc_id = aws_vpc.lms.id
  tags = {
    Name = "lms-nacl"
  }
}

# NACL Rules - Inbound
resource "aws_network_acl_rule" "lms-ingress" {
  network_acl_id = aws_network_acl.lms-nacl.id
  rule_number    = 100
  egress         = false
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}

# NACL Rules - Outbound
resource "aws_network_acl_rule" "lms-egress" {
  network_acl_id = aws_network_acl.lms-nacl.id
  rule_number    = 100
  egress         = true
  protocol       = "tcp"
  rule_action    = "allow"
  cidr_block     = "0.0.0.0/0"
  from_port      = 0
  to_port        = 65535
}

# NACL - Subnet - Association
resource "aws_network_acl_association" "nacl-subnet" {
  network_acl_id = aws_network_acl.lms-nacl.id
  subnet_id      = aws_subnet.lms-subnet.id
}