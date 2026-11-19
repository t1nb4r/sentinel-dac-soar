output "workspace_id" {
    description = "Die Resource-ID des Log Analytics Workspace"
    value       = azurerm_log_analytics_workspace.law.id
}

output "workspace_name" {
    description = "Der Name des Log Analytics Workspace"
    value       = azurerm_log_analytics_workspace.law.name
}