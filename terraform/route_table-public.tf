# -------------------------------------------
# Public
# -------------------------------------------
# NATゲートウェイと関連付けるために作成する
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-public_rt"
  }
}

# Publicには、インターネットゲートウェイに繋がるルートを追加する
resource "aws_route" "public_rt_igw_r" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# ルートテーブルとサブネットを関連付ける
resource "aws_route_table_association" "public_rt_ap-northeast-1a" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.subnet_public_ap-northeast-1a.id
}
resource "aws_route_table_association" "public_rt_ap-northeast-1c" {
  route_table_id = aws_route_table.public_rt.id
  subnet_id      = aws_subnet.subnet_public_ap-northeast-1c.id
}
