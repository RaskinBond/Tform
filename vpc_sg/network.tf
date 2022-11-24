resource "aws_vpc" "mh1" {
  cidr_block        = var.vpc_cidr
}

resource "aws_subnet" "mumbai" {
  count             = length(var.subnet_tags)
  vpc_id            = aws_vpc.mh1.id
  cidr_block        = cidrsubnet(var.vpc_cidr,8,count.index)
  availability_zone = format("${var.region}%s", count.index%2==0?"a":"b")

  tags   = {
    Name = var.subnet_tags[count.index]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id            = aws_vpc.mh1.id

  tags   = {
    Name = "IGW"
  }
}

resource "aws_s3_bucket" "my_bucket" {
  bucket            = var.buckets3
}

resource "aws_security_group" "Web_server" {
  vpc_id             = aws_vpc.mh1.id
  description        = local.default_description
  
  ingress {
    from_port        = local.ssh_port
    to_port          = local.ssh_port
    protocol         = local.tcp
    cidr_blocks      = [local.anywhere]
  }

  ingress {
    from_port        = local.http_port
    to_port          = local.http_port
    protocol         = local.tcp
    cidr_blocks      = [local.anywhere]
  }

  egress {
    from_port        = local.all_ports
    to_port          = local.all_ports
    protocol         = local.protocol
    cidr_blocks      = [local.anywhere]
    ipv6_cidr_blocks = [local.anywhere_ipv6]
  }

  tags = {
    Name = "Web Security"
  }
}

resource "aws_security_group" "App_server" {
  vpc_id             = aws_vpc.mh1.id
  description        = local.default_description

  ingress {
    from_port        = local.ssh_port
    to_port          = local.ssh_port
    protocol         = local.tcp
    cidr_blocks      = [local.anywhere]
  }

  ingress {
    from_port        = local.app_port
    to_port          = local.app_port
    protocol         = local.tcp
    cidr_blocks      = [var.vpc_cidr]
  }

  egress {
    from_port        = local.all_ports
    to_port          = local.all_ports
    protocol         = local.protocol
    cidr_blocks      = [local.anywhere]
    ipv6_cidr_blocks = [local.anywhere_ipv6]
  }

  tags = {
    Name = "App Security"
  }
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.mh1.id

  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = PublicRT
  }
}

resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.mh1.id

  tags = {
    Name = PrivateRT
  }
}

