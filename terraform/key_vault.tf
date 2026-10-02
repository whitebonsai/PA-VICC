resource "azurerm_key_vault" "main" {
  name                = "kv-${var.project_name}-${var.environment}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = data.azurerm_client_config.current.tenant_id
  sku_name            = "standard"

  rbac_authorization_enabled = true
  purge_protection_enabled   = false # deaktiviert damit destroy und apply wiederholt möglich sind
}

# Rolle für den angemeldeten Benutzer zum Lesen und Schreiben von Secrets
resource "azurerm_role_assignment" "kv_admin" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

# wg-easy-Admin-Passwort für beide VMs
resource "azurerm_key_vault_secret" "wg_admin_password" {
  name         = "wg-admin-password"
  value        = var.wg_admin_password_seed
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.kv_admin]
}