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
  resource_group_name = var.key_vault_resource_group
}

# Data source for existing DNS Zone
data "azurerm_dns_zone" "existing" {
  name                = var.dns_zone_name
  resource_group_name = var.dns_zone_resource_group
}

