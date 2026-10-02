# Ablage der wg-easy-Datenbank für den Sync von VM1 nach VM2
resource "azurerm_storage_account" "backup" {
  # Storage-Account-Namen dürfen keine Bindestriche enthalten und müssen global eindeutig sein
  name                     = "st${replace(var.project_name, "-", "")}${var.environment}"
  resource_group_name      = azurerm_resource_group.main.name
  location                 = azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

resource "azurerm_storage_container" "wg_backup" {
  name                  = "wireguard-backups"
  storage_account_id    = azurerm_storage_account.backup.id
  container_access_type = "private"
}
