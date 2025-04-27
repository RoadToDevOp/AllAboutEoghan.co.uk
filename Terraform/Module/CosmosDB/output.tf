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

output "cosmos_db_connection_string" {
  value = azurerm_cosmosdb_account.cosmos_db_account.connection_strings[0]
  sensitive = true
}

output "database_name" {
  value = azurerm_cosmosdb_sql_database.cosmosdb_sql_database.name
}

output "container_name" {
  value = azurerm_cosmosdb_sql_container.cosmosdb_sql_container.name
}


