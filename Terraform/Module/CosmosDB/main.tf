locals {
  default_tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Module      = "CosmosDB"
    Purpose     = "Data Storage"
  }
  
  merged_tags = merge(local.default_tags, var.tags)
}

resource "azurerm_cosmosdb_account" "cosmos_db_account" {
  name                = var.account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  capabilities {
    name = "EnableServerless"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  tags = local.merged_tags
}

resource "azurerm_cosmosdb_sql_database" "cosmosdb_sql_database" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos_db_account.name
}

resource "azurerm_cosmosdb_sql_container" "cosmosdb_sql_container" {
  name                = var.container_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.cosmos_db_account.name
  database_name       = azurerm_cosmosdb_sql_database.cosmosdb_sql_database.name
  partition_key_paths = "/id"

  indexing_policy {
    indexing_mode = "consistent"
  }
}