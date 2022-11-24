variable "region" {
  type          = string
  default       = "ap-southeast-1"
}

variable "vpc_cidr" {
    type        = list(string)
    default     = [ "192.168.0.0/16", "10.10.0.0/16" ]
}

variable "vpc_tags" {
    type        = list
    default     = [ "Gen", "Next"]
}


variable "subnet_tags" {
    type        = list(string)
    default     = [ "web1", "web2", "app1", "app2", "db1", "db2" ]
}

variable "gateway" {
    type        = string
    default     = "internet"
}

variable "security" {
    type        = list(string)
    default = [ "Web Security Group", "App Security Group" ]
}
