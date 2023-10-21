# -------------------------------------------
# VPC
# -------------------------------------------
resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    "Name" = "${var.project}-vpc"
  }
}

# -------------------------------------------
# Subnet
# -------------------------------------------
# アベイラビリティゾーン: ap-northeast-1a
resource "aws_subnet" "subnet_public_ap-northeast-1a" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.0.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_public_ap-northeast-1a"
  }
}

resource "aws_subnet" "subnet_private1_ap-northeast-1a" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.128.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_private1_ap-northeast-1a"
  }
}

resource "aws_subnet" "subnet_private3_ap-northeast-1a" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.160.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_private3_ap-northeast-1a"
  }
}

# アベイラビリティゾーン: ap-northeast-1c
resource "aws_subnet" "subnet_public_ap-northeast-1c" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.16.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_public_ap-northeast-1c"
  }
}

resource "aws_subnet" "subnet_private2_ap-northeast-1c" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.144.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_private2_ap-northeast-1c"
  }
}

resource "aws_subnet" "subnet_private4_ap-northeast-1c" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.176.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_private4_ap-northeast-1c"
  }
}

# -------------------------------------------
# Internet Gateway
# -------------------------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-igw"
  }
}

# -------------------------------------------
# Route Table
# -------------------------------------------
### Public
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

### Private EC2
resource "aws_route_table" "private_rt_ec2_ap-northeast-1a" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-private_rt_ec2_ap-northeast-1a"
  }
}
resource "aws_route_table" "private_rt_ec2_ap-northeast-1c" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-private_rt_ec2_ap-northeast-1c"
  }
}

# ルートテーブルとサブネットを関連付ける
resource "aws_route_table_association" "private_rt_ec2_private1_ap-northeast-1a" {
  route_table_id = aws_route_table.private_rt_ec2_ap-northeast-1a.id
  subnet_id      = aws_subnet.subnet_private1_ap-northeast-1a.id
}
resource "aws_route_table_association" "private_rt_ec2_private2_ap-northeast-1c" {
  route_table_id = aws_route_table.private_rt_ec2_ap-northeast-1c.id
  subnet_id      = aws_subnet.subnet_private2_ap-northeast-1c.id
}

resource "aws_route" "private_rt_ec2_1a_nat_r" {
  route_table_id         = aws_route_table.private_rt_ec2_ap-northeast-1a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_ap-northeast-1a.id
}

resource "aws_route" "private_rt_ec2_1c_nat_r" {
  route_table_id         = aws_route_table.private_rt_ec2_ap-northeast-1c.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway_ap-northeast-1c.id
}

### Private RDS
resource "aws_route_table" "private_rt_rds" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-private_rt_rds"
  }
}

# ルートテーブルとサブネットを関連付ける
resource "aws_route_table_association" "private_rt_rds_private3_ap-northeast-1a" {
  route_table_id = aws_route_table.private_rt_rds.id
  subnet_id      = aws_subnet.subnet_private3_ap-northeast-1a.id
}
resource "aws_route_table_association" "private_rt_rds_private4_ap-northeast-1c" {
  route_table_id = aws_route_table.private_rt_rds.id
  subnet_id      = aws_subnet.subnet_private4_ap-northeast-1c.id
}

# -------------------------------------------
# Elastic IP
# -------------------------------------------
resource "aws_eip" "eip_for_nat_gateway_ap-northeast-1a" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-eip_for_nat_gateway_ap-northeast-1a"
  }
}
resource "aws_eip" "eip_for_nat_gateway_ap-northeast-1c" {
  domain = "vpc"

  tags = {
    Name = "${var.project}-eip_for_nat_gateway_ap-northeast-1c"
  }
}

# -------------------------------------------
# NAT Gateway
# -------------------------------------------
resource "aws_nat_gateway" "nat_gateway_ap-northeast-1a" {
  allocation_id = aws_eip.eip_for_nat_gateway_ap-northeast-1a.id
  subnet_id     = aws_subnet.subnet_public_ap-northeast-1a.id

  tags = {
    Name = "${var.project}-nat_gateway_ap-northeast-1a"
  }
}
resource "aws_nat_gateway" "nat_gateway_ap-northeast-1c" {
  allocation_id = aws_eip.eip_for_nat_gateway_ap-northeast-1c.id
  subnet_id     = aws_subnet.subnet_public_ap-northeast-1c.id

  tags = {
    Name = "${var.project}-nat_gateway_ap-northeast-1c"
  }
}

# -------------------------------------------
# EC2 Instance Connect Endpoint
# -------------------------------------------
resource "aws_ec2_instance_connect_endpoint" "ec2_instance_connect_endpoint_ap-northeast-1a" {
    subnet_id = aws_subnet.subnet_private1_ap-northeast-1a.id
    security_group_ids = [aws_security_group.sg_ec2_instance_connect_endpoint.id]
    preserve_client_ip = true

    tags = {
        Name = "${var.project}-ec2_instance_connect_endpoint_ap-northeast-1a"
    }
}

# resource "aws_ec2_instance_connect_endpoint" "ec2_instance_connect_endpoint_ap-northeast-1c" {
#     subnet_id = aws_subnet.subnet_private2_ap-northeast-1c.id
#     security_group_ids = [aws_security_group.sg_ec2_instance_connect_endpoint.id]
#     preserve_client_ip = true

#     tags = {
#         Name = "${var.project}-ec2_instance_connect_endpoint_ap-northeast-1c"
#     }
# }

# -------------------------------------------
# Securty Group（EC2 Instance Connect Endpoint）
# -------------------------------------------
resource "aws_security_group" "sg_ec2_instance_connect_endpoint" {
  name   = "${var.project}-sg_ec2_instance_connect_endpoint"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-sg_ec2_instance_connect_endpoint"
  }
}

resource "aws_security_group_rule" "ec2_instance_connect_endpoint_ingress" {
  description       = "All traffic from lb"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2_instance_connect_endpoint.id
}

resource "aws_security_group_rule" "ec2_instance_connect_endpoint_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_ec2_instance_connect_endpoint.id
}
