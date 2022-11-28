variable "region" {
    type            = string
    default         = "ap-south-1"
}

variable "vpc_cidr" {
    type            = string
    default         = "10.10.0.0/16"
}

variable "subnet_tags" {
    type            = list(string)
    default         = [ "web1", "web2", "app1", "app2", "db1", "db2" ]
}

variable "buckets3" {
    type            = string
    default         = "qts3exercise1"
}

variable "public_subnets" {
    type            = list(string)
    default         = [ "web1", "web2" ]
}

variable "app_subnets" {
    type            = list(string)
    default         = [ "app1", "app2" ]
}

variable "db_subnets" {
    type            = list(string)
    default         = [ "db1", "db2" ]
}

variable "key_pair" {
    type            = string
    default         = "~/.ssh/id_rsa.pub"
}


variable "appserver_info" {
    type                    = object ({
        count               = number
        name                = string
        ami_id              = string
        instance_type       = string
        subnets             = list(string)
        public_ip_enabled   = bool
    })
    default                 = {
        count               = 2
        name                = "appservr"
        ami_id              = "ami-062df10d14676e201"
        instance_type       = "t2.micro"
        subnets             = ["appl", "app2"]
        public_ip_enabled   = false

    } 
}

variable "webserver_info" {
    
    type                    = object ({
        count               = number
        name                = string
        ami_id              = string
        instance_type       = string
        subnets             = list(string)
        public_ip_enabled   = bool
    })
    default                 = {
        count               = 2
        name                = "webservr"
        ami_id              = "ami-062df10d14676e201"
        instance_type       = "t2.micro"
        subnets             = ["webl", "web2"]
        public_ip_enabled   = true 

    } 
}