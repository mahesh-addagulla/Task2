resource "azurerm_virtual_network" "vnet1" {
  name                = "${var.rgname}-vnet1"
  address_space       = var.address_space_list
  location            = azurerm_resource_group.azb40rg1.location
  resource_group_name = azurerm_resource_group.azb40rg1.name

  tags = {
    environment = var.env
    batch       = "B40"
  }
}

resource "azurerm_subnet" "web-subnets" {
  count                = length(var.web_subnets_cidr)
  name                 = "${var.rgname}-Web-Subnet-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.azb40rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [element(var.web_subnets_cidr, count.index)]
}

resource "azurerm_subnet" "app-subnets" {
  count                = length(var.app_subnets_cidr)
  name                 = "${var.rgname}-App-Subnet-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.azb40rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [element(var.app_subnets_cidr, count.index)]
}

resource "azurerm_subnet" "db-subnets" {
  count                = length(var.db_subnets_cidr)
  name                 = "${var.rgname}-Db-Subnet-${count.index + 1}"
  resource_group_name  = azurerm_resource_group.azb40rg1.name
  virtual_network_name = azurerm_virtual_network.vnet1.name
  address_prefixes     = [element(var.db_subnets_cidr, count.index)]
}
