output "storage_account_id" {
  description = "The ID of the storage account."
  value       = azurerm_storage_account.storage.id
}

output "storage_account_name" {
  description = "The name of the storage account."
  value       = azurerm_storage_account.storage.name
}

output "storage_account_primary_access_key" {
  description = "The primary access key for the storage account."
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
}

output "storage_account_primary_connection_string" {
  description = "The primary connection string for the storage account."
  value       = azurerm_storage_account.storage.primary_connection_string
  sensitive   = true
}

output "storage_account_primary_blob_endpoint" {
  description = "The primary blob endpoint of the storage account."
  value       = azurerm_storage_account.storage.primary_blob_endpoint
}

output "storage_account_primary_queue_endpoint" {
  description = "The primary queue endpoint of the storage account."
  value       = azurerm_storage_account.storage.primary_queue_endpoint
}

output "storage_account_primary_table_endpoint" {
  description = "The primary table endpoint of the storage account."
  value       = azurerm_storage_account.storage.primary_table_endpoint
}

output "storage_account_primary_file_endpoint" {
  description = "The primary file endpoint of the storage account."
  value       = azurerm_storage_account.storage.primary_file_endpoint
}

