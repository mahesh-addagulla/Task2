resource "random_integer" "random_number" {
  count = 3
  min   = 1111
  max   = 9999
}

resource "azurerm_storage_account" "azb40straccount" {
  count                    = 3
  name                     = "azb40terraform${var.env}00${count.index + 1}"
  resource_group_name      = azurerm_resource_group.azb40rg1.name
  location                 = azurerm_resource_group.azb40rg1.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  depends_on               = [azurerm_dns_a_record.slb]
}

resource "azurerm_storage_container" "containers" {
  count                 = 3
  name                  = lower(var.containername)
  storage_account_name  = element(azurerm_storage_account.azb40straccount.*.name, count.index)
  container_access_type = "private"
}