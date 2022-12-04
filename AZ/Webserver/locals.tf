locals {
    direction                       = "Inbound"
    access                          = "Allow"
    protocol                        = "Tcp"
    source_port_range               = "*"
    destination_port_range          = "*"
    source_address_prefix           = "*"
    destination_address_prefix      = "*"

    ssh                             = "22"
    http                            = "80"

    sku_name                        = "Basic"
    allocation_method               = "Dynamic"
    private_ip_address_allocation   = "Dynamic"

    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    
}