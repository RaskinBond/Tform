data "azurerm_subnet" "appsubnet" {
    name                            = var.appsubnet
    resource_group_name             = azurerm_resource_group.terraform.name
    virtual_network_name            = azurerm_virtual_network.vnet.name

    depends_on = [
        azurerm_subnet.mumbai
    ]
}


# Network Interface
resource "azurerm_network_interface" "appnic" {
    name                            = "app_nic"
    resource_group_name             = azurerm_resource_group.terraform.name
    location                        = azurerm_resource_group.terraform.location

  ip_configuration {
    name                            = var.app_ipconfig_name
    subnet_id                       = data.azurerm_subnet.appsubnet.id
    private_ip_address_allocation   = local.private_ip_address_allocation
  }
  depends_on = [
    data.azurerm_subnet.appsubnet
  ]
}

resource "azurerm_network_interface_security_group_association" "appnsg_association" {
    network_interface_id            = azurerm_network_interface.appnic.id
    network_security_group_id       = azurerm_network_security_group.app_nsg.id
}

resource "azurerm_linux_virtual_machine" "app_server" {
    name                            = var.appserver_vm_info.name
    resource_group_name             = azurerm_resource_group.terraform.name
    location                        = azurerm_resource_group.terraform.location
    size                            = var.appserver_vm_info.size
    admin_username                  = var.username
    admin_password                  = var.password
    network_interface_ids           = [azurerm_network_interface.appnic.id]
    disable_password_authentication = var.appserver_vm_info.disable_password_authentication
  
  source_image_reference {
    publisher                       = var.appserver_vm_info.publisher
    offer                           = var.appserver_vm_info.offer
    sku                             = var.appserver_vm_info.sku
    version                         = var.appserver_vm_info.version
  }

  os_disk {
    caching                         = local.caching
    storage_account_type            = local.storage_account_type
  }
}


# resource "null_resource" "prvt_ntwrk" {
#   connection {
#     type                            = "ssh"
#     bastion_user                    = var.username
#     bastion_password                = var.password
#     host                            = azurerm_linux_virtual_machine.app_server.private_ip_address
#   }

#   provisioner "file" {
#     source      = "./shell/script.sh"
#     destination = "/temp/script.sh"
#   }
  
#   provisioner "remote-exec" {
#     inline      = [
#       "chmod +x /tmp/script.sh"
#     ]
#   }
  
#   provisioner "remote-exec" {
#     script      = "/temp/script.sh"
#   }
# }



