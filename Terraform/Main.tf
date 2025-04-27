locals {
  default_tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
  }

  merged_tags = merge(
    local.default_tags,
    var.tags
  )
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = local.merged_tags
}

# Data source for existing Key Vault
data "azurerm_key_vault" "existing" {
  name                = var.key_vault_name
  resource_group_name = var.Anchor_resource
}

# Data source for existing DNS Zone
data "azurerm_dns_zone" "existing" {
  name                = var.dns_zone_name
  resource_group_name = var.Anchor_resource
}

resource "azurerm_static_web_app" "Static_web_app" {
  name = "all-about-eoghan-live"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

module "cosmosdb_deployment" {
  source = "./Module/CosmosDB"
  
  account_name       = "all-about-eoghan-cosmos"
  database_name      = "resume-db"
  container_name     = "visitors"
  location           = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags               = local.merged_tags
  partition_key_path = 
}

module "Function_app_deployment" {
  source = "./Module/FunctionApp"
  function_app_name    = "all-about-eoghan-func"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  cors_allowed_origins = ["https://allabouteoghan.co.uk"]
  tags                = local.merged_tags
  additional_app_settings = {
    "COSMOS_DB_CONNECTION_STRING" = azurerm_cosmosdb_account.cosmos_db_account.connection_strings[0]
  }
}

