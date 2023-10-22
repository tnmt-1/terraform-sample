resource "aws_db_subnet_group" "mysql_subnet_group" {
  name = "${var.project}-mysql-dbsubnetgroup"
  subnet_ids = [
    aws_subnet.subnet_private3_ap-northeast-1a.id,
    aws_subnet.subnet_private4_ap-northeast-1c.id
  ]

  tags = {
    Name = "${var.project}-mysql-subnetgroup"
  }
}
