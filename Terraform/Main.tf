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

module "static-web-site" {
  source = "./Module/Website"
  location = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  static_web_app_name = "AllAboutEoghanLIVE"
  dns_resource_group_name = data.azurerm_dns_zone.existing.resource_group_name
  dns_zone_name = data.azurerm_dns_zone.existing.name
  domain_name = data.azurerm_dns_zone.existing.name 
}

module "cosmosdb_deployment" {
  source = "./Module/CosmosDB"
  
  account_name       = "all-about-eoghan-cosmos"
  database_name      = "resume-db"
  container_name     = "visitors"
  location           = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags               = local.merged_tags
}

resource "azurerm_key_vault_secret" "cosmos_connection_string" {
  name         = "cosmos-connection-string"
  value        = module.cosmosdb_deployment.cosmos_db_connection_string
  key_vault_id = data.azurerm_key_vault.existing.id
}


module "Function_app_deployment" {
  source = "./Module/FunctionApp"
  
  function_app_name    = "all-about-eoghan-func"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  cors_allowed_origins = ["https://allabouteoghan.co.uk"]
  tags                = local.merged_tags
  additional_app_settings = {
    "COSMOS_DB_CONNECTION_STRING" = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.cosmos_connection_string.id})"
    "COSMOS_DB_DATABASE_NAME" = module.cosmosdb_deployment.database_name
    "COSMOS_DB_CONTAINER_NAME" = module.cosmosdb_deployment.container_name
  }
}

resource "azurerm_key_vault_access_policy" "function_app" {
  key_vault_id = data.azurerm_key_vault.existing.id
  tenant_id    = module.Function_app_deployment.identity_tenant_id
  object_id    = module.Function_app_deployment.identity_principal_id
  
  secret_permissions = [
    "Get",
    "List"
  ]
}
