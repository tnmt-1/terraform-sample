# -------------------------------------------
# Nat Gateway
# -------------------------------------------
# ap-northeast-1a
resource "aws_eip" "eip_for_nat_gateway_ap-northeast-1a" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-eip_for_nat_gateway_ap-northeast-1a"
  }
}

# ap-northeast-1c
resource "aws_eip" "eip_for_nat_gateway_ap-northeast-1c" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-eip_for_nat_gateway_ap-northeast-1c"
  }
}

# -------------------------------------------
# EC2
# -------------------------------------------
# ap-northeast-1a
resource "aws_eip" "eip_for_ec2_ap-northeast-1a" {
  domain   = "vpc"
  instance = aws_instance.ec2_ap-northeast-1a.id

  tags = {
    Name = "${var.project}-eip_for_ec2_ap-northeast-1a"
  }
}

# ap-northeast-1c
resource "aws_eip" "eip_for_ec2_ap-northeast-1c" {
  domain   = "vpc"
  instance = aws_instance.ec2_ap-northeast-1c.id

  tags = {
    Name = "${var.project}-eip_for_ec2_ap-northeast-1c"
  }
}
