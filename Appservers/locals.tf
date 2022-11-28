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

    allocated_storage   = 20
    db_name             = "rds_db"
    db_subnet_groupname = "db-subnet-group"
    engine              = "mysql"
    engine_version      = "8.0.28"
    instance_class      = "db.t3.micro"
    username            = "admin"
    password            = "admin123"
    final_snapshot      = true
    identifier          = "myfirstrdsfromtf"
}

