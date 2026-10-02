# DNS-Failover von VM1 auf VM2
resource "azurerm_traffic_manager_profile" "gateway" {
  name                   = "tm-${var.project_name}-${var.environment}"
  resource_group_name    = azurerm_resource_group.main.name
  traffic_routing_method = "Priority"

  dns_config {
    relative_name = "${var.project_name}-${var.environment}"
    ttl           = 30
  }

  monitor_config {
    protocol = "HTTP"
    port     = 51821
    path     = "/login" # Root-Pfad antwortet mit 302 und gilt als Fehler

    interval_in_seconds          = 30
    timeout_in_seconds           = 10
    tolerated_number_of_failures = 3
  }
}

resource "azurerm_traffic_manager_external_endpoint" "vm1" {
  name       = "gateway1"
  profile_id = azurerm_traffic_manager_profile.gateway.id
  target     = module.gateway_vm1.public_ip_address
  priority   = 1
}

resource "azurerm_traffic_manager_external_endpoint" "vm2" {
  name       = "gateway2"
  profile_id = azurerm_traffic_manager_profile.gateway.id
  target     = module.gateway_vm2.public_ip_address
  priority   = 2
}
