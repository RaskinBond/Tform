#1 Create a resource group
resource "azurerm_resource_group" "terraform" {
    name                        = "fromtf"
    location                    = var.location
}

#2 Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
    name                        = "az_vnet"
    resource_group_name         = azurerm_resource_group.terraform.name
    location                    = azurerm_resource_group.terraform.location
    address_space               = var.vnet_cidr

    depends_on              = [
        azurerm_resource_group.terraform
    ]
}

#3 Creating Subnets
resource "azurerm_subnet" "mumbai" {
    count                       = length(var.subnet_tags)
    name                        = var.subnet_tags[count.index]
    resource_group_name         = azurerm_resource_group.terraform.name
    virtual_network_name        = azurerm_virtual_network.vnet.name
    address_prefixes            = [cidrsubnet(var.vnet_cidr[0],8,count.index)]

    depends_on = [
        azurerm_resource_group.terraform,
        azurerm_virtual_network.vnet
    ]
}

#4 Creating Network Security group
resource "azurerm_network_security_group" "app_nsg" {
    name                        = "AppSecurityGroup"
    resource_group_name         = azurerm_resource_group.terraform.name
    location                    = azurerm_resource_group.terraform.location

security_rule {
    name                        = local.name
    priority                    = local.priority
    direction                   = local.direction
    access                      = local.access
    protocol                    = local.protocol
    source_port_range           = local.source_port_range
    destination_port_range      = local.destination_port_range
    source_address_prefix       = var.vnet_cidr[0]
    destination_address_prefix  = local.destination_address_prefix
    }
    depends_on                  = [
        azurerm_resource_group.terraform
    ]
}


resource "azurerm_network_security_group" "web_nsg" {
    name                        = "WebSecurityGroup"
    location                    = azurerm_resource_group.terraform.location
    resource_group_name         = azurerm_resource_group.terraform.name

security_rule {
    name                        = local.name
    priority                    = local.priority
    direction                   = local.direction
    access                      = local.access
    protocol                    = local.protocol
    source_port_range           = local.source_port_range
    destination_port_range      = local.destination_port_range
    source_address_prefix       = local.source_address_prefix
    destination_address_prefix  = local.destination_address_prefix
    }
    depends_on                  = [
        azurerm_resource_group.terraform
    ]
}

