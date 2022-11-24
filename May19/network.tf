resource "aws_vpc" "myvpc" {
  cidr_block    = "10.10.0.0/16"

    tags    = {
    Name    = "from-tf"
  }
}

resource "aws_subnet" "web-1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.10.0.0/24"
  availability_zone = "ap-south-1a"
    
    tags    = {
    Name    = "web-1-tf"
  }
}

resource "aws_subnet" "web-2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "ap-south-1a"
    
    tags    = {
    Name    = "web-2-tf"
  }
}

resource "aws_subnet" "db-1" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.10.2.0/24"
  availability_zone = "ap-south-1a"
    
    tags    = {
    Name    = "db-1-tf"
  }
}

resource "aws_subnet" "db-2" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "ap-south-1a"
    
    tags    = {
    Name    = "db-2-tf"
  }
}