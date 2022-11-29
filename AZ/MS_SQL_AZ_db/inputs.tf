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


variable "mssql_server_info" {
    type                                    = object({
        name                                = string
        administrator_login                 = string
        administrator_login_password        = string
        version                             = string
    })

    default                                 = {
        name                                = "dbservertf"
        administrator_login                 = "tfdevops"
        administrator_login_password        = "quarantino#7276107829"
        version                             = "12.0"
    }
}

variable "mssql_db_name" {
    type        = string
    default     = "sequel"
}