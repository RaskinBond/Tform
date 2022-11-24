variable "name" {
  type    = list
  default = [ "Space", "Axe" ]
}

variable "location" {
  type    = string
  default = "Central India"
}

variable "network_cidr1" {
  type    = list(string)
  default = [ "192.168.0.0/16", "10.10.0.0/16" ]
}

# variable "network_cidr2" {
#   type    = list(string)
#   default = [ "10.10.0.0/16" ]
# }

variable "subnet_names" {
  type    = list(string)
  default = [ "web1", "app1", "web2", "app2" ]
}

variable "security_name" {
  type    = string
  default = "az_sg"
  
}

variable "security_tag" {
  type    = string
  default = "security"
}
