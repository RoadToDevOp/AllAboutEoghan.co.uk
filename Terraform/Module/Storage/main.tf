locals {
  default_tags = {
    Environment = "Production"
    ManagedBy   = "Terraform"
    Module      = "Storage"
  }

  merged_tags = merge(
    local.default_tags,
    var.tags
  )
}

resource "azurerm_storage_account" "storage" {
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  account_kind                    = var.account_kind
  min_tls_version                = var.min_tls_version
  blob_properties {
    versioning_enabled       = false
    last_access_time_enabled = false
    change_feed_enabled      = false
  }
  tags = local.merged_tags
}

resource "azurerm_storage_account_network_rules" "rules" {
  count               = length(var.network_rules.virtual_network_subnet_ids) > 0 || length(var.network_rules.ip_rules) > 0 ? 1 : 0
  storage_account_id  = azurerm_storage_account.storage.id
  default_action      = var.network_rules.default_action
  ip_rules            = var.network_rules.ip_rules
  virtual_network_subnet_ids = var.network_rules.virtual_network_subnet_ids
  bypass              = var.network_rules.bypass
}

