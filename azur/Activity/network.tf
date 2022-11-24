#1 Create a resource group
resource "azurerm_resource_group" "terraform" {
    name     = "tfse"
    location = "Central India"
}

#2 Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
    name                = "az_vnet"
    resource_group_name = azurerm_resource_group.terraform.name
    location            = azurerm_resource_group.terraform.location
    address_space       = var.vnet_cidr
}

#3 Creating Subnets
resource "azurerm_subnet" "mumbai" {
    count                = length(var.subnet_tags)
    name                 = var.subnet_tags[count.index]
    resource_group_name  = azurerm_resource_group.terraform.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = [cidrsubnet(var.vnet_cidr[0],8,count.index)]
}
