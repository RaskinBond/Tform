resource "aws_vpc" "sgp" {
  cidr_block = var.network_cidr
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.sgp.id

  tags   = {
    Name = "main"
  }
}

# loop
resource "aws_subnet" "dynamic" {
  count             = length(var.subnets_tags)
  vpc_id            = aws_vpc.sgp.id
  cidr_block        = cidrsubnet(var.network_cidr,8,count.index)
  availability_zone = format("${var.region}%s",count.index%2==0?"a":"b")
  
  tags   = {
    Name = var.subnets_tags[count.index]
  }
}


resource "aws_s3_bucket" "b" {
    bucket      = "tf-tst-bckt"

  tags          = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}