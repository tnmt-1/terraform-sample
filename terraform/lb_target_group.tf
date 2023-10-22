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

  depends_on = [aws_lb.lb]
}

resource "aws_lb_target_group_attachment" "target_ec2_1a" {
  target_group_arn = aws_lb_target_group.blue_tg.arn
  target_id        = aws_instance.ec2_ap-northeast-1a.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "target_ec2_1c" {
  target_group_arn = aws_lb_target_group.blue_tg.arn
  target_id        = aws_instance.ec2_ap-northeast-1c.id
  port             = 80
}
