#Define locals
locals {
  env   = lower(var.env)
  batch = lower(var.batch)
}

# Create Virtual Machines public-ip
resource "azurerm_public_ip" "vms" {
  count               = var.env == "Development" || var.env == "development" || var.env == "dev" || var.env == "Dev" ? 3 : 1
  sku                 = "Standard"
  name                = "vms-pip-${count.index}"
  location            = azurerm_resource_group.azb40rg1.location
  resource_group_name = azurerm_resource_group.azb40rg1.name
  allocation_method   = "Static"
  tags = {
    Env   = local.env
    Batch = local.batch
  }
}

# Create Virtual Machine Network Interface
resource "azurerm_network_interface" "vms" {
  count               = var.env == "Development" || var.env == "development" || var.env == "dev" || var.env == "Dev" ? 3 : 1
  name                = "vms-nic-${count.index}"
  location            = azurerm_resource_group.azb40rg1.location
  resource_group_name = azurerm_resource_group.azb40rg1.name
  ip_configuration {
    name                          = "vms-ipconfig-${count.index}"
    subnet_id                     = element(azurerm_subnet.web-subnets.*.id, count.index)
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.vms.*.id, count.index)
  }
  tags = {
    Env   = local.env
    Batch = local.batch
  }
}

# Create Azure Linux Virtual Machines
resource "azurerm_linux_virtual_machine" "vms" {
  count                           = var.env == "Development" || var.env == "development" || var.env == "dev" || var.env == "Dev" ? 3 : 1
  name                            = "${azurerm_resource_group.azb40rg1.name}-vm-${count.index + 1}"
  resource_group_name             = azurerm_resource_group.azb40rg1.name
  location                        = azurerm_resource_group.azb40rg1.location
  size                            = var.vm_size
  admin_username                  = var.admin_username
  admin_password                  = element(azurerm_key_vault_secret.password1_secret.*.value, count.index)
  disable_password_authentication = false
  network_interface_ids = [
    element(azurerm_network_interface.vms.*.id, count.index)
  ]
  #   depends_on = [azurerm_key_vault_access_policy.anand-user-access]
  os_disk {
    name                 = "vm${count.index + 1}OSDisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = "30"
  }
  identity {
    type = "SystemAssigned"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal-daily"
    sku       = "20_04-daily-lts-gen2"
    version   = "latest"
  }
}