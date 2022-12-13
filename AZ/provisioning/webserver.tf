data "azurerm_subnet" "websubnet" {
    name                            = var.websubnet
    resource_group_name             = azurerm_resource_group.terraform.name
    virtual_network_name            = azurerm_virtual_network.vnet.name

    depends_on = [
        azurerm_subnet.mumbai
    ]
}


# Public_IP
resource "azurerm_public_ip" "webip" {
    name                            = var.public_ip
    resource_group_name             = azurerm_resource_group.terraform.name
    location                        = azurerm_resource_group.terraform.location
    allocation_method               = local.allocation_method

    depends_on = [
      data.azurerm_subnet.websubnet
    ]
}


# Network Interface
resource "azurerm_network_interface" "webnic" {
    name                            = "web_nic"
    resource_group_name             = azurerm_resource_group.terraform.name
    location                        = azurerm_resource_group.terraform.location

  ip_configuration {
    name                            = var.web_ipconfig_name
    subnet_id                       = data.azurerm_subnet.websubnet.id
    public_ip_address_id            = azurerm_public_ip.webip.id
    private_ip_address_allocation   = local.private_ip_address_allocation
  }

    depends_on = [
      data.azurerm_subnet.websubnet
    ]
}

resource "azurerm_network_interface_security_group_association" "webnsg_association" {
    network_interface_id            = azurerm_network_interface.webnic.id
    network_security_group_id       = azurerm_network_security_group.web_nsg.id
}

resource "azurerm_linux_virtual_machine" "web_server" {
    name                            = var.webserver_vm_info.name
    resource_group_name             = azurerm_resource_group.terraform.name
    location                        = azurerm_resource_group.terraform.location
    size                            = var.webserver_vm_info.size
    admin_username                  = var.username
    admin_password                  = var.password
    network_interface_ids           = [azurerm_network_interface.webnic.id]
    disable_password_authentication = var.webserver_vm_info.disable_password_authentication

  source_image_reference {
    publisher                       = var.webserver_vm_info.publisher
    offer                           = var.webserver_vm_info.offer
    sku                             = var.webserver_vm_info.sku
    version                         = var.webserver_vm_info.version
  }

  os_disk {
    caching                         = local.caching
    storage_account_type            = local.storage_account_type
  }

    depends_on = [
      azurerm_linux_virtual_machine.app_server
    ]
}

resource "null_resource" "connect" {
   
   triggers     = {
      "execute" = var.increment_execute
  }

  connection {
    type                            = "ssh"
    user                            = var.username
    password                        = var.password
    host                            = azurerm_linux_virtual_machine.web_server.public_ip_address
  }

  provisioner "remote-exec" {
    inline = [
      "#!/bin/bash",
      "sudo apt update",
      "sudo apt install apache2 -y",
      "sudo apt install software-properties-common -y",
      "sudo add-apt-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "ansible --version",
      "ansible-playbook --version",
      "sudo apt install tree -y"
    ]
  }

    depends_on = [
      azurerm_linux_virtual_machine.app_server
    ]
}  

