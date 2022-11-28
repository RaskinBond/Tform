resource "azurerm_resource_group" "network" {
  name     = local.name
  location = var.location
}

resource "azurerm_virtual_network" "vnet" {
  count               = length(var.name)
  name                = var.name[count.index]
  location            = var.location
  resource_group_name = azurerm_resource_group.network.name
  address_space       = [ var.network_cidr1[0], var.network_cidr1[1] ]
}

resource "azurerm_subnet" "sub1" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet[0].name
  address_prefixes     = [cidrsubnet(var.network_cidr1[0], local.eight, count.index)]
}


resource "azurerm_subnet" "sub2" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.network.name
  virtual_network_name = azurerm_virtual_network.vnet[1].name
  address_prefixes     = [cidrsubnet(var.network_cidr1[1], local.eight, count.index)]

}

resource "azurerm_network_security_group" "az_net_sg" {
  name                = var.security_name
  location            = azurerm_resource_group.network.location
  resource_group_name = azurerm_resource_group.network.name

  security_rule {
    name                       = local.name
    priority                   = local.priority
    direction                  = local.direction
    access                     = local.access
    protocol                   = local.protocol
    source_port_range          = local.source_port_range
    destination_port_range     = local.dest_port_range
    source_address_prefix      = local.source_addr_prfix
    destination_address_prefix = local.dest_addr_prfix
  }

  tags = {
    environment = var.security_tag
  }
}




