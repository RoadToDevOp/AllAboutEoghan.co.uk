output "static_web_app_id" {
  description = "The ID of the Static Web App"
  value       = azurerm_static_web_app.static_web_app.id
}

output "static_web_app_name" {
  description = "The name of the Static Web App"
  value       = azurerm_static_web_app.static_web_app.name
}

output "default_host_name" {
  description = "The default hostname of the Static Web App"
  value       = azurerm_static_web_app.static_web_app.default_host_name
}

output "custom_domain" {
  description = "The custom domain configured for the Static Web App"
  value       = var.domain_name
}

output "api_key" {
  description = "The API key for the Static Web App"
  value       = azurerm_static_web_app.static_web_app.api_key
  sensitive   = true
}

output "deployment_token" {
  description = "The deployment token for the Static Web App"
  value       = azurerm_static_web_app.static_web_app.deployment_token
  sensitive   = true
}