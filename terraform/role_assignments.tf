# Zugriff der VM-Identities auf den Blob Storage ohne Storage-Key
resource "azurerm_role_assignment" "vm1_blob" {
  scope                = azurerm_storage_account.backup.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.gateway_vm1.principal_id
}

resource "azurerm_role_assignment" "vm2_blob" {
  scope                = azurerm_storage_account.backup.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = module.gateway_vm2.principal_id
}