variable "region" {
    type        =  string
    default     = "ap-southeast-1" 
}


variable "network_cidr" {
    type        = string
    default     = "10.0.0.0/16"
    description = "cidr range of VPC"
}


variable "subnets_tags" {
    type        = list(string)
    default     = [ "web1", "web2", "app1", "app2", "db1", "db2" ]
}


# variable "availability_zones" {
#     type        = list(string)
#     default     = [ "ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1a", "ap-southeast-1b", "ap-southeast-1a", "ap-southeast-1b" ]
# }


# variable "subnets_cidr" {
#     type        = list(string)
#     default     = [ "10.0.0.0/24", "10.0.1.0/24", "10.0.2.0/24","10.0.3.0/24", "10.0.4.0/24", "10.0.5.0/24" ]
# }

