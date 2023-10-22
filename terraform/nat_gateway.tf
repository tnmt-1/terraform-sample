# -------------------------------------------
# ap-northeast-1a
# -------------------------------------------
resource "aws_nat_gateway" "nat_gateway_ap-northeast-1a" {
  allocation_id = aws_eip.eip_for_nat_gateway_ap-northeast-1a.id
  subnet_id     = aws_subnet.subnet_public_ap-northeast-1a.id

  tags = {
    Name = "${var.project}-nat_gateway_ap-northeast-1a"
  }
}

# -------------------------------------------
# ap-northeast-1c
# -------------------------------------------
resource "aws_nat_gateway" "nat_gateway_ap-northeast-1c" {
  allocation_id = aws_eip.eip_for_nat_gateway_ap-northeast-1c.id
  subnet_id     = aws_subnet.subnet_public_ap-northeast-1c.id

  tags = {
    Name = "${var.project}-nat_gateway_ap-northeast-1c"
  }
}