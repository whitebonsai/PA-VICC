variable "name_suffix" {
  description = "Suffix zur Unterscheidung der VMs, z.B. \"1\" oder \"2\""
  type        = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "private_ip_address" {
  type = string
}

variable "vm_size" {
  type    = string
  default = "Standard_B2als_v2"
}

variable "admin_username" {
  type = string
}

variable "admin_ssh_public_key" {
  type = string
}

variable "wg_host" {
  description = "Endpoint in den Client-Configs, Traffic-Manager-FQDN damit der Failover beim Client greift"
  type        = string
}

variable "wg_admin_username" {
  type = string
}

variable "wg_admin_password" {
  type      = string
  sensitive = true
}

variable "storage_account_name" {
  type = string
}

variable "storage_container_name" {
  type = string
}

variable "sync_role" {
  description = "\"push\" für die aktive VM, \"pull\" für die passive"
  type        = string
}

variable "zone" {
  description = "Availability Zone für diese VM"
  type        = string
}