resource "aws_db_subnet_group" "db_sub_group" {
  name       = local.db_subnet_groupname
  subnet_ids = data.aws_subnets.db_subnets.ids

  depends_on = [
    aws_subnet.mumbai
  ]
}

resource "aws_db_instance" "database" {
  allocated_storage         = local.allocated_storage
  db_name                   = local.db_name
  db_subnet_group_name      = local.db_subnet_groupname
  engine                    = local.engine
  engine_version            = local.engine_version
  instance_class            = local.instance_class
  username                  = local.username
  password                  = local.password
  skip_final_snapshot       = local.final_snapshot
  identifier                = local.identifier

  depends_on = [
    aws_db_subnet_group.db_sub_group
  ] 
}
