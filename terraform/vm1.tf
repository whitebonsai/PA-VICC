# Aktive VM mit Upload der Datenbank und einziger Ort zum Anlegen von Clients
module "gateway_vm1" {
  source = "./modules/gateway-vm"

  name_suffix            = "1"
  environment            = var.environment
  location               = var.location
  zone                   = "1"
  resource_group_name    = azurerm_resource_group.main.name
  subnet_id              = azurerm_subnet.gateway.id
  private_ip_address     = "10.10.1.4"
  admin_username         = var.admin_username
  admin_ssh_public_key   = var.admin_ssh_public_key
  wg_host                = azurerm_traffic_manager_profile.gateway.fqdn
  wg_admin_username      = var.wg_admin_username
  wg_admin_password      = azurerm_key_vault_secret.wg_admin_password.value
  storage_account_name   = azurerm_storage_account.backup.name
  storage_container_name = azurerm_storage_container.wg_backup.name
  sync_role              = "push"
}