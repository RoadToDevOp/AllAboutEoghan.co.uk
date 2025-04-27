locals {
  default_tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Module      = "CosmosDB"
    Purpose     = "Data Storage"
  }
  
  merged_tags = merge(local.default_tags, var.tags)
}

resource "azurerm_cosmosdb_account" "this" {
  name                = var.account_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = var.enable_automatic_failover

  consistency_policy {
    consistency_level       = var.consistency_level
    max_interval_in_seconds = var.max_interval_in_seconds
    max_staleness_prefix    = var.max_staleness_prefix
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  tags = local.merged_tags
}

resource "azurerm_cosmosdb_sql_database" "this" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  throughput          = var.database_throughput
}

resource "azurerm_cosmosdb_sql_container" "this" {
  name                = var.container_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  database_name       = azurerm_cosmosdb_sql_database.this.name
  partition_key_path  = var.partition_key_path
  throughput          = var.container_throughput

  indexing_policy {
    indexing_mode = "consistent"
  }
}


