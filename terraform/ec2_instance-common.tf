# -------------------------------------------
# AMI
# -------------------------------------------
# 最新のAmazonLinux2のイメージ
data "aws_ami" "latest_amzn2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
