variable "region" {
  type          = string
  default       = "ap-south-1"
}

variable "vpc_cidr" {
    type        = string
    default     = "10.10.0.0/16"
}

variable "subnet_tags" {
    type        = list(string)
    default     = [ "web1", "web2", "app1", "app2", "db1", "db2" ]
}

variable "buckets3" {
    type        = string
    default     = "qts3exercise1"
}
