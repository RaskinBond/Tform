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
  depends_on = [
    aws_vpc.mh1
  ]
}

resource "aws_internet_gateway" "igw" {
  vpc_id            = aws_vpc.mh1.id

  tags   = {
    Name = "IGW"
  }
  depends_on = [
    aws_vpc.mh1,
    aws_subnet.mumbai
  ]
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
  depends_on = [
    aws_vpc.mh1
  ]
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
  depends_on = [
    aws_vpc.mh1
  ]
}

resource "aws_security_group" "db_server" {
  vpc_id             = aws_vpc.mh1.id
  description        = local.default_description

  ingress {
    from_port        = local.ssh_port
    to_port          = local.ssh_port
    protocol         = local.tcp
    cidr_blocks      = [local.anywhere]
  }

  ingress {
    from_port        = local.db_port
    to_port          = local.db_port
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
    Name = "DB Security"
  }
  depends_on = [
    aws_vpc.mh1
  ]
}

resource "aws_route_table" "publicrt" {
  vpc_id = aws_vpc.mh1.id

  route {
    cidr_block = local.anywhere
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "PublicRT"
  }
  depends_on = [
    aws_internet_gateway.igw
  ]
}

resource "aws_route_table" "privatert" {
  vpc_id = aws_vpc.mh1.id

  tags = {
    Name = "PrivateRT"
  }
  depends_on = [
    aws_internet_gateway.igw
  ]
}

# Route Table Association
resource "aws_route_table_association" "routes" {
  count           = length(aws_subnet.mumbai)
  subnet_id       = aws_subnet.mumbai[count.index].id
  route_table_id  = contains(var.public_subnets, lookup(aws_subnet.mumbai[count.index].tags_all, "Name", ""))? aws_route_table.publicrt.id : aws_route_table.privatert.id

  depends_on = [
    aws_route_table.publicrt,
    aws_route_table.privatert
  ]
}

