# Anzeige nach dem Deployment mit tofu output

output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "vnet_id" {
  value = azurerm_virtual_network.main.id
}

output "vm1_public_ip" {
  value = module.gateway_vm1.public_ip_address
}

output "vm2_public_ip" {
  value = module.gateway_vm2.public_ip_address
}

output "traffic_manager_fqdn" {
  value = azurerm_traffic_manager_profile.gateway.fqdn
}

output "key_vault_name" {
  value = azurerm_key_vault.main.name
}

output "backup_storage_account_name" {
  value = azurerm_storage_account.backup.name
}

output "log_analytics_workspace_name" {
  value = azurerm_log_analytics_workspace.main.name
}