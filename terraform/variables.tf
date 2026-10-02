variable "subscription_id" {
  description = "Azure Subscription ID (Student Account)"
  type        = string
}

variable "location" {
  description = "Azure-Region für alle Ressourcen"
  type        = string
  default     = "switzerlandnorth"
}

variable "project_name" {
  description = "Namenspräfix für alle Ressourcen (z.B. für Tagging/Naming Convention)"
  type        = string
  default     = "vicc-pa"
}

variable "environment" {
  description = "Umgebung, z.B. dev oder prod"
  type        = string
  default     = "dev"
}

variable "admin_ip" {
  description = "Öffentliche IP-Adresse (CIDR), von der aus Web-UI und SSH erreichbar sein sollen"
  type        = list(string)
}

variable "admin_username" {
  description = "Admin-Benutzername für die VMs"
  type        = string
  default     = "azureadmin"
}

variable "admin_ssh_public_key" {
  description = "Öffentlicher SSH-Key (Inhalt der .pub-Datei) für den VM-Zugriff"
  type        = string
}

variable "wg_admin_username" {
  type = string
}

variable "wg_admin_password_seed" {
  description = "Initiales wg-easy Admin-Passwort, wird beim ersten Apply in Key Vault geschrieben"
  type        = string
  sensitive   = true
}