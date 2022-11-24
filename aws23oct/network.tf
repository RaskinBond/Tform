resource "aws_vpc" "mh1" {
  count             = length(var.vpc_tags)
  cidr_block        = var.vpc_cidr[count.index]

  tags    = {
    Name  = var.vpc_tags[count.index]

  }
}

resource "aws_subnet" "mumbai" {
  count             = length(var.subnet_tags)
  vpc_id            = aws_vpc.mh1[0].id
  cidr_block        = cidrsubnet(var.vpc_cidr[0], local.eight, count.index)
  availability_zone = format("${var.region}%s", count.index%2==0?"a":"b")

  tags    = {
    Name  = var.subnet_tags[count.index]
  }
}

resource "aws_subnet" "singapore" {
  count             = length(var.subnet_tags)
  vpc_id            = aws_vpc.mh1[1].id
  cidr_block        = cidrsubnet(var.vpc_cidr[1], local.eight, count.index)
  availability_zone = format("${var.region}%s", count.index%2==0?"a":"b")

  tags    = {
    Name  = var.subnet_tags[count.index]
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id            = aws_vpc.mh1[0].id

  tags   = {
    Name = var.gateway
  }
}

resource "aws_security_group" "web" {
  vpc_id             = aws_vpc.mh1[0].id
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

  tags    = {
    Name  = var.security[0]
  }
}

resource "aws_security_group" "app" {
  vpc_id             = aws_vpc.mh1[1].id
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
    cidr_blocks      = var.vpc_cidr
  }

  egress {
    from_port        = local.all_ports
    to_port          = local.all_ports
    protocol         = local.protocol
    cidr_blocks      = [local.anywhere]
    ipv6_cidr_blocks = [local.anywhere_ipv6]
  }

  tags    = {
    Name  = var.security[1]
  }
}