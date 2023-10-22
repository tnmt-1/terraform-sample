### HTTP
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb.arn
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
#   load_balancer_arn = aws_lb.lb.arn
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
#   load_balancer_arn = aws_lb.lb.arn
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
