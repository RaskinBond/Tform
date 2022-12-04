
data "azurerm_subnet" "websubnet" {
    resource_group_name             = azurerm_resource_group.terra.name
    virtual_network_name            = azurerm_virtual_network.vnet.name
    name                            = var.websubnet

    depends_on = [
      azurerm_subnet.mumbai
    ]

}

# Public IP
resource "azurerm_public_ip" "webip" {
    resource_group_name             = azurerm_resource_group.terra.name
    location                        = azurerm_resource_group.terra.location
    name                            = "webpublicip" 
    allocation_method               = local.allocation_method

}

resource "azurerm_network_interface" "webnic" {
    name                            = "webnic"
    resource_group_name             = azurerm_resource_group.terra.name
    location                        = azurerm_resource_group.terra.location
    
    ip_configuration {
      name                          = "appipconfig"
      subnet_id                     = data.azurerm_subnet.websubnet.id
      public_ip_address_id          = azurerm_public_ip.webip.id
      private_ip_address_allocation = local.private_ip_address_allocation
    }

}

resource "azurerm_network_interface_security_group_association" "webnsg_association" {
    network_interface_id            = azurerm_network_interface.webnic.id
    network_security_group_id       = azurerm_network_security_group.web_nsg.id
}


resource "azurerm_linux_virtual_machine" "webserver" {
    name                            = "webserver"
    resource_group_name             = azurerm_resource_group.terra.name
    location                        = azurerm_resource_group.terra.location
    size                            = var.vmsize
    admin_username                  = var.username
    admin_password                  = var.password
    network_interface_ids           = [azurerm_network_interface.webnic.id] 
    disable_password_authentication = false

    source_image_reference {
        publisher                   = var.source_image.publisher
        offer                       = var.source_image.offer
        sku                         = var.source_image.sku
        version                     = var.source_image.version
    }

    os_disk {
        caching                     = local.caching
        storage_account_type        = local.storage_account_type
  }

}