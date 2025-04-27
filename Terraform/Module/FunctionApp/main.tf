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

# Function App
resource "azurerm_windows_function_app" "function_app" {
  name                       = var.function_app_name
  resource_group_name        = var.resource_group_name
  location                   = var.location
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_account_access_key
  service_plan_id            = var.service_plan_id
  
  site_config {
    application_stack {
      python_version = var.python_version
    }
    cors {
      allowed_origins = var.cors_allowed_origins
      support_credentials = true
    }
  }
  
  app_settings = merge(
    {
      "FUNCTIONS_WORKER_RUNTIME" = "python"
      "COSMOS_ENDPOINT"         = var.cosmos_endpoint
      "COSMOS_KEY"             = var.cosmos_key
      "COSMOS_DATABASE"        = var.cosmos_database
      "COSMOS_CONTAINER"       = var.cosmos_container
    },
    var.additional_app_settings
  )
  
  tags = local.merged_tags
}

# Storage Account for Function App
resource "azurerm_storage_account" "function_storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.merged_tags
}

# App Service Plan
resource "azurerm_service_plan" "function_plan" {
  name                = var.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type            = "Windows"
  sku_name           = var.app_service_plan_sku
  tags                = local.merged_tags
}

# Function App Deployment
resource "azurerm_windows_function_app_slot" "function_app_slot" {
  count                      = var.create_deployment_slot ? 1 : 0
  name                       = var.deployment_slot_name
  function_app_id            = azurerm_windows_function_app.function_app.id
  storage_account_name       = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key
  
  site_config {
    application_stack {
      python_version = var.python_version
    }
    cors {
      allowed_origins = var.cors_allowed_origins
      support_credentials = true
    }
  }
  
  app_settings = merge(
    {
      "FUNCTIONS_WORKER_RUNTIME"     = "python"
      "COSMOS_ENDPOINT"              = var.cosmos_endpoint
      "COSMOS_KEY"                   = var.cosmos_key
      "COSMOS_DATABASE"              = var.cosmos_database
      "COSMOS_CONTAINER"             = var.cosmos_container
      "WEBSITE_RUN_FROM_PACKAGE"     = "1"
      "SCM_DO_BUILD_DURING_DEPLOYMENT" = "true"
    },
    var.additional_app_settings
  )
  
  tags = local.merged_tags
}


