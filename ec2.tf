locals {
  ip_range_all = "0.0.0.0/0"
}

resource "aws_instance" "read" {
  ami                         = data.aws_ami.ami_linux.id
  instance_type               = var.instance_type
  subnet_id                   = data.aws_subnet.subnet.id
  associate_public_ip_address = true
  key_name                    = var.keypair
  vpc_security_group_ids      = [aws_security_group.dynamo-sg.id]
  iam_instance_profile        = aws_iam_instance_profile.read_profile.id

  tags = {
    Name = "${local.resource_prefix}-dynamodb-reader"
  }
}

resource "aws_security_group" "dynamo-sg" {
  name        = "${local.resource_prefix}-dynamodb-SG"
  description = "Security Group created for DynamoDB read"
  vpc_id      = data.aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allowhttps" {
  security_group_id = aws_security_group.dynamo-sg.id

  cidr_ipv4   = local.ip_range_all
  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "allowssh" {
  security_group_id = aws_security_group.dynamo-sg.id

  cidr_ipv4   = local.ip_range_all
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
}

resource "aws_vpc_security_group_egress_rule" "outgoing" {
  security_group_id = aws_security_group.dynamo-sg.id

  cidr_ipv4   = local.ip_range_all
  from_port   = -1
  ip_protocol = "-1"
  to_port     = -1
}