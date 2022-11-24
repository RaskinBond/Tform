variable "region" {
    type        = string
    default     = "ap-southeast-1" 
}

variable "vpc_cidr" {
    type        = string
    default     = "10.10.0.0/16" 
}

variable "subnet_tags" {
    type        = list(string)
    default     = [ "web1", "web2", "db1", "db2" ]
}

variable "subnet_azs" {
    type        = list(string)
    default = [ "ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1a", "ap-southeast-1b" ] 
  
}