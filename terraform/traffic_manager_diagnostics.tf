# Schreibt die Health-Check-Ergebnisse pro Endpunkt nach Log Analytics
resource "azurerm_monitor_diagnostic_setting" "traffic_manager" {
  name                       = "diag-tm-${var.environment}"
  target_resource_id         = azurerm_traffic_manager_profile.gateway.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id

  enabled_log {
    category = "ProbeHealthStatusEvents"
  }
}
