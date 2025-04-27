output "function_app_name" {
  description = "The name of the Function App."
  value       = azurerm_windows_function_app.function_app.name
}

output "function_app_id" {
  description = "The ID of the Function App."
  value       = azurerm_windows_function_app.function_app.id
}

output "function_app_default_hostname" {
  description = "The default hostname of the Function App."
  value       = azurerm_windows_function_app.function_app.default_hostname
}

output "function_app_identity" {
  description = "The identity of the Function App."
  value       = azurerm_windows_function_app.function_app.identity
}

output "function_app_key" {
  description = "The key of the Function App."
  value       = azurerm_windows_function_app.function_app.key
  sensitive   = true
}

output "function_app_url" {
  description = "The URL of the Function App."
  value       = "https://${azurerm_windows_function_app.function_app.default_hostname}"
}


