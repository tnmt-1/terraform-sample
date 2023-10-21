# -------------------------------------------
# Securty Group
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
# ALB
# -------------------------------------------
resource "aws_lb" "alb" {
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

# -------------------------------------------
# Listener
# -------------------------------------------
### HTTP
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.blue_tg.arn
  }
}

# HTTPSを有効にするときは、こっちを設定したい
# Route53やACMの設定が必要なので保留
# HTTPSにリダイレクト設定
# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = "80"
#   protocol          = "HTTP"
# 
#   default_action {
#     type = "redirect"
# 
#     redirect {
#       port        = "443"
#       protocol    = "HTTPS"
#       status_code = "HTTP_301"
#     }
#   }
# }

### HTTPS
# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.alb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.tokyo_cert.arn
# 
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.blue_tg.arn
#   }
# }

# -------------------------------------------
# Target Group
# -------------------------------------------
resource "aws_lb_target_group" "blue_tg" {
  name                 = "${var.project}-blue-tg"
  vpc_id               = aws_vpc.vpc.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/"
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 15
    matcher             = 200
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [aws_lb.alb]
}

resource "aws_lb_target_group_attachment" "target_ec2_1a" {
  target_group_arn = aws_lb_target_group.blue_tg.arn
  target_id        = aws_instance.ec2_ap-northeast-1a.id
  port             = 80
}

# resource "aws_lb_target_group_attachment" "target_ec2_1c" {
#   target_group_arn = aws_lb_target_group.blue_tg.arn
#   target_id        = aws_instance.ec2_ap-northeast-1c.id
#   port             = 80
# }
