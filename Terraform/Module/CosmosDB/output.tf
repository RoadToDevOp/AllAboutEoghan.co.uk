output "cosmosdb_account_name" {
  description = "The name of the CosmosDB account."
  value       = azurerm_cosmosdb_account.this.name
}

output "cosmosdb_account_endpoint" {
  description = "The endpoint of the CosmosDB account."
  value       = azurerm_cosmosdb_account.this.endpoint
}

output "cosmosdb_database_name" {
  description = "The name of the CosmosDB SQL database."
  value       = azurerm_cosmosdb_sql_database.this.name
}

output "cosmosdb_container_name" {
  description = "The name of the CosmosDB SQL container."
  value       = azurerm_cosmosdb_sql_container.this.name
}

output "cosmosdb_account_id" {
  description = "The resource ID of the CosmosDB account."
  value       = azurerm_cosmosdb_account.this.id
}


