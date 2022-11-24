//resource "aws_s3_bucket" "mug" {
// bucket = "bathroom-bucket"
//  tags = {
//    Name        = "My mug"
//    Environment = "test"
//  }
//}

resource "aws_vpc" "singapore" {
    cidr_block = var.vpc_cidr
}

resource "aws_subnet" "sub_nets" {
    count               = length(var.subnet_tags)
    vpc_id              = aws_vpc.singapore.id
    cidr_block          = cidrsubnet(var.vpc_cidr,8,count.index)
    availability_zone   = var.subnet_azs[count.index]

  tags = {
    Name = var.subnet_tags[count.index]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.singapore.id

  tags = {
    Name = "IGW"
  }
}
