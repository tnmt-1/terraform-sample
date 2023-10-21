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

# -------------------------------------------
# Securty Group
# -------------------------------------------
resource "aws_security_group" "sg_ec2" {
  name   = "${var.project}-sg_ec2"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-sg_ec2"
  }
}

resource "aws_security_group_rule" "ec2_from_lb_ingress" {
  description              = "All traffic from lb"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.sg_lb.id
  security_group_id        = aws_security_group.sg_ec2.id
}

resource "aws_security_group_rule" "ec2_from_instance_connect_endpoint_ingress" {
  description              = "All traffic from instance connect endpoint"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = aws_security_group.sg_ec2_instance_connect_endpoint.id
  security_group_id        = aws_security_group.sg_ec2.id
}

resource "aws_security_group_rule" "ec2_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2.id
}


# # -------------------------------------------
# # Key Pair
# # -------------------------------------------
# resource "aws_key_pair" "keypair" {
#   key_name   = "${var.project}-ec2-keypair"
#   public_key = file("./ec2-keypair/keypair_aws.pub")

#   tags = {
#     Name = "${var.project}-ec2-keypair"
#   }
# }

# -------------------------------------------
# Instance
# -------------------------------------------
resource "aws_instance" "ec2_ap-northeast-1a" {
  ami                         = data.aws_ami.latest_amzn2.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet_private1_ap-northeast-1a.id
  # associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg_ec2.id]
  # key_name                    = aws_key_pair.keypair.key_name

  tags = {
    Name = "${var.project}-ec2_ap-northeast-1a"
  }
}

# resource "aws_instance" "ec2_ap-northeast-1c" {
#   ami                         = data.aws_ami.latest_amzn2.id
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.subnet_private2_ap-northeast-1c.id
#   associate_public_ip_address = true
#   vpc_security_group_ids      = [aws_security_group.sg_ec2.id]
# #   key_name                    = aws_key_pair.keypair.key_name

#   tags = {
#     Name = "${var.project}-ec2_ap-northeast-1c"
#   }
# }

# -------------------------------------------
# Elastic IP
# -------------------------------------------
resource "aws_eip" "eip_for_ec2_ap-northeast-1a" {
  domain   = "vpc"
  instance = aws_instance.ec2_ap-northeast-1a.id

  tags = {
    Name = "${var.project}-eip_for_ec2_ap-northeast-1a"
  }
}

# resource "aws_eip" "eip_for_ec2_ap-northeast-1c" {
#   domain   = "vpc"
#   instance = aws_instance.ec2_ap-northeast-1c.id

#   tags = {
#     Name = "${var.project}-eip_for_ec2_ap-northeast-1c"
#   }
# }

output "ec2_instance_id-1a" {
  value = aws_instance.ec2_ap-northeast-1a.*.id
}

# output "ec2_instance_id-1c" {
#   value = aws_instance.ec2_ap-northeast-1c.*.id
# }