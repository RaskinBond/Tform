data "azurerm_subnet" "appsubnet" {
    resource_group_name             = azurerm_resource_group.terra.name
    virtual_network_name            = azurerm_virtual_network.vnet.name
    name                            = var.appsubnet

    depends_on = [
      azurerm_subnet.mumbai
    ]

}


# Network Interface
resource "azurerm_network_interface" "appnic" {
    name                            = "appnic"
    resource_group_name             = azurerm_resource_group.terra.name
    location                        = azurerm_resource_group.terra.location
    ip_configuration {
      name                          = "appipconfig"
      subnet_id                     = data.azurerm_subnet.appsubnet.id
      private_ip_address_allocation = local.private_ip_address_allocation
    }
}


resource "azurerm_network_interface_security_group_association" "appnsg_association" {
    network_interface_id            = azurerm_network_interface.appnic.id
    network_security_group_id       = azurerm_network_security_group.app_nsg.id
}


resource "azurerm_linux_virtual_machine" "appserver" {
    name                            = "appserver"
    resource_group_name             = azurerm_resource_group.terra.name
    location                        = azurerm_resource_group.terra.location
    size                            = var.vmsize
    admin_username                  = var.username
    admin_password                  = var.password
    network_interface_ids           = [azurerm_network_interface.appnic.id] 
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