variable "location" {
    type        = string
    default     = "Central India"
}

variable "vnet_cidr" {
    type        = list(string)
    default     = [ "10.0.0.0/16" ]
}

variable "subnet_tags" {
    type        = list(string)
    default     = [ "web", "app", "db" ]
}


variable "mysql_info" {
    type                                    = object({
        mysql_admin_login                   = string
        mysql_admin_password                = string
        mysql_sku_name                      = string
        mysql_version                       = string
        mysql_storage                       = string
        public_network_access_enabled       = bool
        ssl_enforcement_enabled             = bool
        ssl_minimal_tls_version_enforced    = string
    })

    default                                 = {
        mysql_admin_login                   = "tfdevops"
        mysql_admin_password                = "quarantino#7276107829"
        mysql_sku_name                      = "B_Gen5_1"
        mysql_version                       = "8.0"
        mysql_storage                       = "5120"
        public_network_access_enabled       = true
        ssl_enforcement_enabled             = true
        ssl_minimal_tls_version_enforced    = "TLS1_2"
    }
}

variable "server_name" {
    type        = string
    default     = "dbservertf"
}

variable "db_name" {
    type        = string
    default     = "mydb"
}
