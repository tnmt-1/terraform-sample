# パスワード
resource "random_string" "db_password" {
  length  = 16
  special = false
}

resource "aws_db_instance" "mysql" {
  engine         = var.rds_engine
  engine_version = var.rds_engine_verison

  # AWSで作成されるデータベース名
  identifier     = "${var.project}-mysql"
  username       = "admin"
  password       = random_string.db_password.result
  instance_class = "db.t2.micro"

  allocated_storage     = 20
  max_allocated_storage = 50
  storage_type          = "gp2"
  storage_encrypted     = false

  multi_az = true
  # マルチAZをOFFにする場合は以下のように書く
  # multi_az               = false
  # availability_zone      = "ap-northeast-1a"
  db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
  vpc_security_group_ids = [aws_security_group.sg_rds.id]
  publicly_accessible    = false
  port                   = 3306

  # MySQLで作成されるデータベース名
  parameter_group_name = aws_db_parameter_group.mysql_parametergroup.name

  backup_window              = "04:00-05:00"
  backup_retention_period    = 7
  maintenance_window         = "Mon:05:00-Mon:06:00"
  auto_minor_version_upgrade = false

  deletion_protection = false
  skip_final_snapshot = true
  apply_immediately   = true

  tags = {
    Name = "${var.project}-mysql"
  }
}
