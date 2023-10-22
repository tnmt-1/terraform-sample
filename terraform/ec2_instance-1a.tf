# -------------------------------------------
# Instance
# -------------------------------------------
resource "aws_instance" "ec2_ap-northeast-1a" {
  ami                    = data.aws_ami.latest_amzn2.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.subnet_private1_ap-northeast-1a.id
  vpc_security_group_ids = [aws_security_group.sg_ec2.id]

  tags = {
    Name = "${var.project}-ec2_ap-northeast-1a"
  }
}

