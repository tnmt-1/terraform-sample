resource "aws_lb" "lb" {
  name               = "${var.project}-alb"
  load_balancer_type = "application"
  internal           = false

  subnets = [
    aws_subnet.subnet_private1_ap-northeast-1a.id,
    aws_subnet.subnet_private2_ap-northeast-1c.id,
  ]

  security_groups = [
    aws_security_group.sg_lb.id
  ]
}
