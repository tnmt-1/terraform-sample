# -------------------------------------------
# ap-northeast-1a
# -------------------------------------------
### public subnet
resource "aws_subnet" "subnet_public_ap-northeast-1a" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.0.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_public_ap-northeast-1a"
  }
}

### private subnet 1
# EC2で使用する
resource "aws_subnet" "subnet_private1_ap-northeast-1a" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.128.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_private1_ap-northeast-1a"
  }
}

### private subnet 3
# RDSで使用する
resource "aws_subnet" "subnet_private3_ap-northeast-1a" {
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.160.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_private3_ap-northeast-1a"
  }
}

# -------------------------------------------
# ap-northeast-1c
# -------------------------------------------
resource "aws_subnet" "subnet_public_ap-northeast-1c" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.16.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_public_ap-northeast-1c"
  }
}

### private subnet 2
# EC2で使用する
resource "aws_subnet" "subnet_private2_ap-northeast-1c" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.144.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_private2_ap-northeast-1c"
  }
}

### private subnet 4
# RDSで使用する
resource "aws_subnet" "subnet_private4_ap-northeast-1c" {
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.176.0/20"
  vpc_id            = aws_vpc.vpc.id
  tags = {
    "Name" = "${var.project}-subnet_private4_ap-northeast-1c"
  }
}
