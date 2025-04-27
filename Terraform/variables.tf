variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy resources"
  type        = string
  default     = "eastus"
}

variable "key_vault_name" {
  description = "The name of the existing Key Vault"
  type        = string
}

variable "key_vault_resource_group" {
  description = "The resource group containing the Key Vault"
  type        = string
}

variable "dns_zone_name" {
  description = "The name of the existing DNS Zone"
  type        = string
}

variable "dns_zone_resource_group" {
  description = "The resource group containing the DNS Zone"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to all resources"
  type        = map(string)
  default     = {}
}

