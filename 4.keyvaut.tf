resource "random_password" "passwords" {
  count            = 3
  length           = 16
  special          = true
  min_upper        = 4
  min_lower        = 4
  min_numeric      = 4
  min_special      = 4
  override_special = "!_%@#"
}



data "azurerm_key_vault" "azureb42kv" {
  provider            = azurerm.Prod
  name                = "azureb42kv"
  resource_group_name = "COMMON-RG"
}

resource "azurerm_key_vault_secret" "password1_secret" {
  provider     = azurerm.Prod
  count        = 3
  name         = "${var.env}b42password${count.index + 1}"
  value        = element(random_password.passwords.*.result, count.index)
  key_vault_id = data.azurerm_key_vault.azureb42kv.id
}

output "key_vault_id" {
  value = data.azurerm_key_vault.azureb42kv.id
}