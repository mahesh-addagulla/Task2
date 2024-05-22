# Create an Azure Network Security Group
resource "azurerm_network_security_group" "azb40nsg" {
  name                = "${azurerm_resource_group.azb40rg1.name}-nsg"
  location            = azurerm_resource_group.azb40rg1.location
  resource_group_name = azurerm_resource_group.azb40rg1.name
}

# Create an NSG rule allowing all inbound traffic
resource "azurerm_network_security_rule" "allow_inbound" {
  name                        = "allow-inbound"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.azb40rg1.name
  network_security_group_name = azurerm_network_security_group.azb40nsg.name
}

# Create an NSG rule allowing all outbound traffic
resource "azurerm_network_security_rule" "allow_outbound" {
  name                        = "allow-outbound"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.azb40rg1.name
  network_security_group_name = azurerm_network_security_group.azb40nsg.name
}

resource "azurerm_subnet_network_security_group_association" "nsg-assosiation-websvr" {
  count                     = length(var.web_subnets_cidr)
  subnet_id                 = element(azurerm_subnet.web-subnets.*.id, count.index)
  network_security_group_id = azurerm_network_security_group.azb40nsg.id
}

