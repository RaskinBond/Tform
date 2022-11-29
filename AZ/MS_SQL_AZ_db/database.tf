# Creating Resource Group for MySQL
# resource "azurerm_resource_group" "mssql_rg" {
#     name                            = "az_mssql_rg"
#     location                        = var.location
# }

# Creating Microsoft SQL Azure Database Server
resource "azurerm_mssql_server" "dbserver" {
    name                                = var.mssql_server_info.name
    resource_group_name                 = azurerm_resource_group.terraform.name
    location                            = azurerm_resource_group.terraform.location
    version                             = var.mssql_server_info.version
    administrator_login                 = var.mssql_server_info.administrator_login
    administrator_login_password        = var.mssql_server_info.administrator_login_password

    depends_on = [
        azurerm_subnet.mumbai
    ]
}

# Creating Azure SQL Database
resource "azurerm_mssql_database" "mssqldb" {
    name                            = var.mssql_db_name
    server_id                       = azurerm_mssql_server.dbserver.id
    sku_name                        = local.sku_name

    depends_on = [
      azurerm_mssql_server.dbserver
    ]
}