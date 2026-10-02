# Standard-SKU ist zonenredundant und übersteht einen Zonenausfall
resource "azurerm_public_ip" "this" {
  name                = "pip-gateway${var.name_suffix}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "this" {
  name                = "nic-gateway${var.name_suffix}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = var.private_ip_address
    public_ip_address_id          = azurerm_public_ip.this.id
  }
}

resource "azurerm_linux_virtual_machine" "this" {
  name                = "vm-gateway${var.name_suffix}-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
  zone                = var.zone
  admin_username      = var.admin_username

  # Cloud-Init installiert Docker und wg-easy und richtet den Sync ein
  custom_data = base64encode(templatefile("${path.module}/cloud-init.yml.tftpl", {
    wg_host                = var.wg_host
    wg_admin_username      = var.wg_admin_username
    wg_admin_password      = var.wg_admin_password
    storage_account_name   = var.storage_account_name
    storage_container_name = var.storage_container_name
    sync_role              = var.sync_role
  }))

  network_interface_ids = [
    azurerm_network_interface.this.id,
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

  disable_password_authentication = true

  # Identity für den Zugriff auf den Blob Storage
  identity {
    type = "SystemAssigned"
  }
}