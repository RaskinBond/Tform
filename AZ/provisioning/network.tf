#1 Create a resource group
resource "azurerm_resource_group" "terraform" {
    name                        = var.resource_group
    location                    = var.location
}

#2 Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
    name                        = "az_vnet"
    resource_group_name         = azurerm_resource_group.terraform.name
    location                    = azurerm_resource_group.terraform.location
    address_space               = var.vnet_cidr

    depends_on                  = [
        azurerm_resource_group.terraform
    ]
}

#3 Creating Subnets
resource "azurerm_subnet" "mumbai" {
    count                       = length(var.subnet_names)
    name                        = var.subnet_names[count.index]
    resource_group_name         = azurerm_resource_group.terraform.name
    virtual_network_name        = azurerm_virtual_network.vnet.name
    address_prefixes            = [cidrsubnet(var.vnet_cidr[0],8,count.index)]

    depends_on                  = [
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
    name                        = "prvt_net"
    priority                    = 300
    direction                   = local.direction
    access                      = local.access
    protocol                    = local.protocol
    source_port_range           = local.source_port_range
    destination_port_range      = local.destination_port_range
    source_address_prefix       = var.vnet_cidr[0]
    destination_address_prefix  = local.destination_address_prefix
    }

security_rule {
    name                        = "webs"
    priority                    = 310
    direction                   = local.direction
    access                      = local.access
    protocol                    = local.protocol
    source_port_range           = local.source_port_range
    destination_port_range      = local.webserver
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
    name                        = "ssh"
    priority                    = 320
    direction                   = local.direction
    access                      = local.access
    protocol                    = local.protocol
    source_port_range           = local.source_port_range
    destination_port_range      = local.ssh
    source_address_prefix       = local.source_address_prefix
    destination_address_prefix  = local.destination_address_prefix
    }

security_rule {
    name                        = "http"
    priority                    = 330
    direction                   = local.direction
    access                      = local.access
    protocol                    = local.protocol
    source_port_range           = local.source_port_range
    destination_port_range      = local.http
    source_address_prefix       = local.source_address_prefix
    destination_address_prefix  = local.destination_address_prefix
    }    
    depends_on                  = [
        azurerm_resource_group.terraform
    ]
}

resource "azurerm_subnet" "Azure_Bastion_Subnet" {
    name                        = "AzureBastionSubnet"
    resource_group_name         = azurerm_resource_group.terraform.name
    virtual_network_name        = azurerm_virtual_network.vnet.name
    address_prefixes            = var.bastion_subnet_cidr

    depends_on = [
      azurerm_virtual_network.vnet
    ]
}

resource "azurerm_public_ip" "bastion_ip" {
    name                        = "bastion_ip"
    resource_group_name         = azurerm_resource_group.terraform.name
    location                    = azurerm_resource_group.terraform.location
    allocation_method           = local.bastion_allocation_method
    sku                         = local.bastio_sku

    depends_on = [
      azurerm_subnet.Azure_Bastion_Subnet
    ]
}

resource "azurerm_bastion_host" "installations" {
    name                        = "sebastion"
    location                    = azurerm_resource_group.terraform.location
    resource_group_name         = azurerm_resource_group.terraform.name

    ip_configuration {
        name                    = "configs"
        subnet_id               = azurerm_subnet.Azure_Bastion_Subnet.id
        public_ip_address_id    = azurerm_public_ip.bastion_ip.id
    }

    depends_on = [
        azurerm_public_ip.bastion_ip
    ]
}







