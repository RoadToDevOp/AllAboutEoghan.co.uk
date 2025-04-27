# Function App Module - Infrastructure Only
locals {
  default_tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Module      = "FunctionApp"
    Purpose     = "API Backend"
  }
  
  merged_tags = merge(local.default_tags, var.tags)
}

# Consumption-based Service Plan
resource "azurerm_service_plan" "function_plan" {
  name                = "${var.function_app_name}-plan"
  resource_group_name = var.resource_group_name
  location           = var.location
  os_type            = "Windows"
  sku_name           = "Y1" # Consumption plan
  tags               = local.merged_tags
}

# Function App
resource "azurerm_windows_function_app" "function_app" {
  name                       = var.function_app_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  service_plan_id            = azurerm_service_plan.function_plan.id
  
  site_config {
    application_stack {
    }
    cors {
      allowed_origins = var.cors_allowed_origins
      support_credentials = true
    }
  }
  
  app_settings = merge(
    {
      "FUNCTIONS_WORKER_RUNTIME" = "python"
      "WEBSITE_RUN_FROM_PACKAGE" = "1"
      "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.function_insights.instrumentation_key
    },
    var.additional_app_settings
  )
  
  tags = local.merged_tags
}

resource "azurerm_application_insights" "function_insights" {
  name                = "${var.function_app_name}-insights"
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"
  tags                = local.merged_tags
}

resource "random_string" "storage_account_name" {
  length = 16
  numeric = true
  special = false
  upper = false
  
}

# Storage Account for Function App
resource "azurerm_storage_account" "function_storage" {
  name                     = random_string.storage_account_name.result
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.merged_tags
}