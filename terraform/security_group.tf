# -------------------------------------------
# LB
# -------------------------------------------
resource "aws_security_group" "sg_lb" {
  name   = "${var.project}-sg_lb"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-sg_lb"
  }
}

resource "aws_security_group_rule" "lb_ingress_http" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_lb.id
}

resource "aws_security_group_rule" "lb_ingress_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_lb.id
}

resource "aws_security_group_rule" "lb_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_lb.id
}

# -------------------------------------------
# EC2
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

# -------------------------------------------
# RDS
# -------------------------------------------
resource "aws_security_group" "sg_rds" {
  name   = "${var.project}-sg-rds"
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project}-sg_rds"
  }
}

resource "aws_security_group_rule" "db_ingress_mysql_from_ec2" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.sg_ec2.id
  security_group_id        = aws_security_group.sg_rds.id
}

resource "aws_security_group_rule" "db_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.sg_rds.id
}

# -------------------------------------------
# EC2 Instance Connect Endpoint
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
