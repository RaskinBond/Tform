# Creating Resource Group for MySQL
# resource "azurerm_resource_group" "mysql_rg" {
#     name                            = "az_mysql_rg"
#     location                        = var.location
# }

# Creating MySQL Database Server
resource "azurerm_mysql_server" "dbserver" {
    name                                = var.server_name
    location                            = azurerm_resource_group.terraform.location
    resource_group_name                 = azurerm_resource_group.terraform.name
    
    administrator_login                 = var.mysql_info.mysql_admin_login
    administrator_login_password        = var.mysql_info.mysql_admin_password

    version                             = var.mysql_info.mysql_version   
    sku_name                            = var.mysql_info.mysql_sku_name

    storage_mb                          = var.mysql_info.mysql_storage
    
    public_network_access_enabled       = var.mysql_info.public_network_access_enabled
    ssl_enforcement_enabled             = var.mysql_info.ssl_enforcement_enabled
    ssl_minimal_tls_version_enforced    = var.mysql_info.ssl_minimal_tls_version_enforced

    depends_on              = [
        azurerm_subnet.mumbai
    ]
}

# Creating MySQL Database
resource "azurerm_mysql_database" "mysqldb" {
    name                            = var.db_name
    resource_group_name             = azurerm_resource_group.terraform.name
    server_name                     = azurerm_mysql_server.dbserver.name
    charset                         = local.charset
    collation                       = local.collation

    depends_on = [
      azurerm_mysql_server.dbserver
    ]
}