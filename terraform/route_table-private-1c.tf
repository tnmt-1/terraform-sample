# -------------------------------------------
# EC2
# -------------------------------------------
resource "aws_route_table" "private_rt_ec2_ap-northeast-1c" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-private_rt_ec2_ap-northeast-1c"
  }
}

# ルートテーブルとサブネットを関連付ける
resource "aws_route_table_association" "private_rt_ec2_private2_ap-northeast-1c" {
  route_table_id = aws_route_table.private_rt_ec2_ap-northeast-1c.id
  subnet_id      = aws_subnet.subnet_private2_ap-northeast-1c.id
}

# -------------------------------------------
# RDS
# -------------------------------------------
resource "aws_route_table" "private_rt_rds_ap-northeast-1c" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-private_rt_rds_ap-northeast-1c"
  }
}

resource "aws_route_table_association" "private_rt_rds_private1_ap-northeast-1c" {
  route_table_id = aws_route_table.private_rt_rds_ap-northeast-1c.id
  subnet_id      = aws_subnet.subnet_private4_ap-northeast-1c.id
}
