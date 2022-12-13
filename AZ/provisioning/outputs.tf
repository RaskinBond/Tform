output "app_server_ip" {
    value   = azurerm_linux_virtual_machine.app_server.private_ip_address
}

output "web_server_ip" {
    value   = format("http://%s", azurerm_linux_virtual_machine.web_server.public_ip_address)
}

output "bastionhost_name" {
    value   = azurerm_bastion_host.installations.name
}

output "bastionhost_ip" {
    value   = azurerm_public_ip.bastion_ip
}