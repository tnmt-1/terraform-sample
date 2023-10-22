# -------------------------------------------
# ap-northeast-1a
# -------------------------------------------
resource "aws_ec2_instance_connect_endpoint" "ec2_instance_connect_endpoint_ap-northeast-1a" {
  subnet_id          = aws_subnet.subnet_private1_ap-northeast-1a.id
  security_group_ids = [aws_security_group.sg_ec2_instance_connect_endpoint.id]
  preserve_client_ip = true

  tags = {
    Name = "${var.project}-ec2_instance_connect_endpoint_ap-northeast-1a"
  }
}

# -------------------------------------------
# ap-northeast-1c
# -------------------------------------------
resource "aws_ec2_instance_connect_endpoint" "ec2_instance_connect_endpoint_ap-northeast-1c" {
  subnet_id          = aws_subnet.subnet_private2_ap-northeast-1c.id
  security_group_ids = [aws_security_group.sg_ec2_instance_connect_endpoint.id]
  preserve_client_ip = true

  tags = {
    Name = "${var.project}-ec2_instance_connect_endpoint_ap-northeast-1c"
  }
}
