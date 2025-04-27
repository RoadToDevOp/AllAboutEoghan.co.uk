output "resource_group_id" {
  description = "The ID of the resource group"
  value       = azurerm_resource_group.rg.id
}

output "key_vault_id" {
  description = "The ID of the existing Key Vault"
  value       = data.azurerm_key_vault.existing.id
}

output "key_vault_uri" {
  description = "The URI of the existing Key Vault"
  value       = data.azurerm_key_vault.existing.vault_uri
}

output "dns_zone_id" {
  description = "The ID of the existing DNS Zone"
  value       = data.azurerm_dns_zone.existing.id
}

output "dns_zone_name_servers" {
  description = "The name servers of the existing DNS Zone"
  value       = data.azurerm_dns_zone.existing.name_servers
}

