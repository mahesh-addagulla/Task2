data "azurerm_dns_zone" "dns_zone" {
  provider            = azurerm.Prod
  name                = var.dns_zone
  resource_group_name = "common-rg"
}

resource "azurerm_dns_a_record" "vms-public-ip" {
  provider            = azurerm.Prod
  count               = var.env == "Development" || var.env == "development" || var.env == "dev" || var.env == "Dev" ? 3 : 1
  name                = "vm${var.env}${count.index + 1}"
  zone_name           = data.azurerm_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
  ttl                 = 300
  records             = [element(azurerm_public_ip.vms.*.ip_address, count.index)]
}
