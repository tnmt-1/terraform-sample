# # -------------------------------------------
# # Securty Group
# # -------------------------------------------
# resource "aws_security_group" "sg_rds" {
#   name   = "${var.project}-sg-rds"
#   vpc_id = aws_vpc.vpc.id

#   tags = {
#     Name = "${var.project}-sg_rds"
#   }
# }

# resource "aws_security_group_rule" "db_ingress_mysql_from_ec2" {
#   type                     = "ingress"
#   from_port                = 3306
#   to_port                  = 3306
#   protocol                 = "tcp"
#   source_security_group_id = aws_security_group.sg_ec2.id
#   security_group_id        = aws_security_group.sg_rds.id
# }

# resource "aws_security_group_rule" "db_egress" {
#   type              = "egress"
#   from_port         = 0
#   to_port           = 0
#   protocol          = "-1"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = aws_security_group.sg_rds.id
# }


# # -------------------------------------------
# # Parameter Group
# # -------------------------------------------
# resource "aws_db_parameter_group" "mysql_parametergroup" {
#   name   = "${var.project}-mysql-parametergroup"
#   family = "mysql8.0"

#   parameter {
#     name  = "character_set_database"
#     value = "utf8mb4"
#   }

#   parameter {
#     name  = "character_set_server"
#     value = "utf8mb4"
#   }
# }

# # -------------------------------------------
# # DB Subnet Group
# # -------------------------------------------
# resource "aws_db_subnet_group" "mysql_subnet_group" {
#   name = "${var.project}-mysql-dbsubnetgroup"
#   subnet_ids = [
#     aws_subnet.subnet_private3_ap-northeast-1a.id,
#     aws_subnet.subnet_private4_ap-northeast-1c.id
#   ]

#   tags = {
#     Name = "${var.project}-mysql-subnetgroup"
#   }
# }

# # -------------------------------------------
# # RDS instance
# # -------------------------------------------
# resource "random_string" "db_password" {
#   length  = 16
#   special = false
# }

# resource "aws_db_instance" "mysql" {
#   engine         = var.rds_engine
#   engine_version = var.rds_engine_verison

#   # AWSで作成されるデータベース名
#   identifier     = "${var.project}-mysql"
#   username       = "admin"
#   password       = random_string.db_password.result
#   instance_class = "db.t2.micro"

#   allocated_storage     = 20
#   max_allocated_storage = 50
#   storage_type          = "gp2"
#   storage_encrypted     = false

#   multi_az               = false
#   availability_zone      = "ap-northeast-1a"
#   db_subnet_group_name   = aws_db_subnet_group.mysql_subnet_group.name
#   vpc_security_group_ids = [aws_security_group.sg_rds.id]
#   publicly_accessible    = false
#   port                   = 3306

#   # MySQLで作成されるデータベース名
#   parameter_group_name = aws_db_parameter_group.mysql_parametergroup.name

#   backup_window              = "04:00-05:00"
#   backup_retention_period    = 7
#   maintenance_window         = "Mon:05:00-Mon:06:00"
#   auto_minor_version_upgrade = false

#   deletion_protection = false
#   skip_final_snapshot = true
#   apply_immediately   = true

#   tags = {
#     Name = "${var.project}-mysql"
#   }
# }
