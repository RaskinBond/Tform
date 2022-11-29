locals {
    name                        = "nsg"
    priority                    = 300
    direction                   = "Inbound"
    access                      = "Allow"
    protocol                    = "Tcp"
    source_port_range           = "*"
    destination_port_range      = "*"
    source_address_prefix       = "*"
    destination_address_prefix  = "*"

    charset                     = "utf8"
    collation                   = "utf8_unicode_ci"
}