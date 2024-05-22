resource "azurerm_resource_group" "azb40rg1" {
  name     = var.rgname
  location = var.location

  tags = {
    environment = var.env
  }
}