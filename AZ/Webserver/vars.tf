variable "location" {
    type    = string
    default = "Central India"
}

variable "network_cidr" {
    type    = list(string)
    default = ["10.0.0.0/16"]
}

variable "subnet_names" {
    type    = list(string)
    default = [ "web", "app", "db"  ]
}

variable "private_endpoint_subnet" {
    type    = string
    default = "db"
}

variable "appsubnet" {
    type    = string
    default = "app"
}

variable "websubnet" {
    type    = string
    default = "web"
}

variable "vmsize" {
    type    = string
    default = "Standard_B1s"
}

variable "username" {
    type    = string
    default = "tfdevops"
}

variable "password" {
    type    = string
    default = "tfdevops#987123"
}

variable "source_image" {
    type                    = object ({
    publisher               = string
    offer                   = string
    sku                     = string
    version                 = string
    })

    default = {
    publisher               = "Canonical"
    offer                   = "0001-com-ubuntu-server-focal"
    sku                     = "20_04-lts-gen2"
    version                 = "latest"
    }
}

