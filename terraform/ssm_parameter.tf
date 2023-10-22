resource "aws_ssm_parameter" "rds_password" {
  name   = "/rds/password"
  type   = "SecureString"
  key_id = "alias/aws/ssm"
  value  = aws_db_instance.mysql.password
}
