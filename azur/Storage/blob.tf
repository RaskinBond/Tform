#Storage Acc

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "sample" {
  name     = "blobs"
  location = "East US"
}

resource "azurerm_storage_account" "example" {
  name                     = "ablobstorage01z"
  resource_group_name      = azurerm_resource_group.sample.name
  location                 = azurerm_resource_group.sample.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    Name        = "Az Blob"
    Environment = "Storage accounts"
  }
}