resource "azurerm_resource_group" "terra" {
    name     = "provs"
    location = var.location
}

resource "azurerm_virtual_network" "vnet" {
    name                        = "az-vnet"
    address_space               = var.network_cidr
    location                    = azurerm_resource_group.terra.location
    resource_group_name         = azurerm_resource_group.terra.name

    depends_on = [
      azurerm_resource_group.terra
    ]
}

resource "azurerm_subnet" "mumbai" {
    count                       = length(var.subnet_names)
    name                        = var.subnet_names[count.index]
    resource_group_name         = azurerm_resource_group.terra.name
    virtual_network_name        = azurerm_virtual_network.vnet.name
    address_prefixes            = [cidrsubnet(var.network_cidr[0],8,count.index)]

    depends_on = [
      azurerm_resource_group.terra,
      azurerm_virtual_network.vnet
    ]
}

resource "azurerm_network_security_group" "app_nsg" {
    name                        = "appnsg"
    location                    = azurerm_resource_group.terra.location
    resource_group_name         = azurerm_resource_group.terra.name

  security_rule {
    name                        = "privatenetwork"
    priority                    = 300
    direction                   = local.direction
    access                      = local.access
    protocol                    = local.protocol
    source_port_range           = local.source_port_range
    destination_port_range      = local.destination_port_range
    source_address_prefix       = var.network_cidr[0]
    destination_address_prefix  = local.destination_address_prefix
  }

  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_network_security_group" "web_nsg" {
    name                        = "webnsg"
    location                    = azurerm_resource_group.terra.location
    resource_group_name         = azurerm_resource_group.terra.name

  security_rule {
    name                        = "ssh"
    priority                    = 310
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
    priority                    = 320
    direction                   = local.direction
    access                      = local.access
    protocol                    = local.protocol
    source_port_range           = local.source_port_range
    destination_port_range      = local.http
    source_address_prefix       = local.source_address_prefix
    destination_address_prefix  = local.destination_address_prefix
  }
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}
