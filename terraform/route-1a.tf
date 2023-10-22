# NATゲートウェイをルート設定してインターネット接続できるようにする
resource "aws_route" "private_rt_ec2_1a_nat_r" {
  route_table_id         = aws_route_table.private_rt_ec2_ap-northeast-1a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_ap-northeast-1a.id
}
