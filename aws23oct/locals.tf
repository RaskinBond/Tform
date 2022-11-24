locals {
    ssh_port            = 22
    http_port           = 80
    all_ports           = 0
    app_port            = 8080
    db_port             = 3306
    tcp                 = "tcp"
    protocol            = "-1"
    anywhere            = "0.0.0.0/0"
    anywhere_ipv6       = "::/0"
    default_description = "From Terraform"
    eight               = "8"
}

