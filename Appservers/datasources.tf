data "aws_subnets" "db_subnets" {
  filter {
    name    = "tag:Name"
    values  = var.db_subnets
  }
  filter {
    name    = "vpc-id"
    values  = [aws_vpc.mh1.id]
  }

  depends_on = [
    aws_subnet.mumbai
  ]
}


data "aws_subnets" "app_subnets" {
  filter {
    name    = "tag:Name"
    values  = var.app_subnets
  }
  filter {
    name    = "vpc-id"
    values  = [aws_vpc.mh1.id]
  }

  depends_on = [
    aws_key_pair.keypair
  ]
}


data "aws_subnets" "web_subnets" {
  filter {
    name    = "tag:Name"
    values  = var.public_subnets
  }
  filter {
    name    = "vpc-id"
    values  = [aws_vpc.mh1.id]
  }

  depends_on = [
    aws_key_pair.keypair
  ]
}