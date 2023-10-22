# -------------------------------------------
# EC2
# -------------------------------------------
resource "aws_route_table" "private_rt_ec2_ap-northeast-1a" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-private_rt_ec2_ap-northeast-1a"
  }
}

resource "aws_route_table_association" "private_rt_ec2_private1_ap-northeast-1a" {
  route_table_id = aws_route_table.private_rt_ec2_ap-northeast-1a.id
  subnet_id      = aws_subnet.subnet_private1_ap-northeast-1a.id
}

# -------------------------------------------
# RDS
# -------------------------------------------
resource "aws_route_table" "private_rt_rds_ap-northeast-1a" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-private_rt_rds_ap-northeast-1a"
  }
}

resource "aws_route_table_association" "private_rt_rds_private1_ap-northeast-1a" {
  route_table_id = aws_route_table.private_rt_rds_ap-northeast-1a.id
  subnet_id      = aws_subnet.subnet_private3_ap-northeast-1a.id
}
