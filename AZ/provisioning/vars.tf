variable "resource_group" {
    type        = string
    default     = "provisioning"
}

variable "location" {
    type        = string
    default     = "Central India" 
}

variable "vnet_cidr" {
    type        = list(string)
    default     = [ "10.0.0.0/16" ]
}

variable "subnet_names" {
    type        = list(string)
    default     = [ "web", "appl", "db" ]
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
    default     = "db"
}

variable "appsubnet" {
    type        = string
    default     = "appl"
}

variable "websubnet" {
    type        = string
    default     = "web"
}

variable "public_ip" {
    type        = string
    default     = "webpublicip" 
}

variable "app_ipconfig_name" {
    type        = string
    default     = "appipconfig"
}

variable "web_ipconfig_name" {
    type        = string
    default     = "webipconfig"
}


variable "appserver_vm_info" {
    type                                = object({
        name                            = string
        publisher                       = string
        offer                           = string
        sku                             = string
        version                         = string
        size                            = string
        disable_password_authentication = string
    })

    default                             = {
        name                            = "appservers"
        publisher                       = "Canonical"
        offer                           = "0001-com-ubuntu-server-focal"
        sku                             = "20_04-lts-gen2"
        version                         = "latest"
        size                            = "Standard_B1s"
        disable_password_authentication = false
    }
}

variable "webserver_vm_info" {
    type                                = object({
        name                            = string
        publisher                       = string
        offer                           = string
        sku                             = string
        version                         = string
        size                            = string
        disable_password_authentication = string
    })

    default                             = {
        name                            = "webservers"
        publisher                       = "Canonical"
        offer                           = "0001-com-ubuntu-server-focal"
        sku                             = "20_04-lts-gen2"
        version                         = "latest"
        size                            = "Standard_B1s"
        disable_password_authentication = false
    }
}

variable "username" {
    type        = string
    default     = "tfdevops"
}

variable "password" {
    type        = string
    default     = "tfdevops#987123"
}

variable "createdb" {
    type        = bool
    default     = "true"
}

variable "increment_execute" {
    type = string
    default = "0"
}

variable "bastion_subnet_cidr" {
    type = list(string)
    default = [ "10.0.5.0/24" ]
}