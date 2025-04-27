variable "static_web_app_name" {
  description = "Name of the Static Web App"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group where the Static Web App will be created"
  type        = string
}

variable "location" {
  description = "Azure region where the Static Web App will be deployed"
  type        = string
}

variable "sku_tier" {
  description = "The pricing tier of the Static Web App"
  type        = string
  default     = "Standard"
}

variable "sku_size" {
  description = "The size of the Static Web App"
  type        = string
  default     = "Standard"
}

variable "domain_name" {
  description = "The custom domain name to use for the Static Web App"
  type        = string
}

variable "dns_zone_name" {
  description = "Name of the existing DNS zone"
  type        = string
}

variable "dns_resource_group_name" {
  description = "Name of the resource group containing the DNS zone"
  type        = string
}

variable "subdomain_prefix" {
  description = "Subdomain prefix (e.g., 'www' or '' for root domain)"
  type        = string
  default     = "www"
}

variable "dns_ttl" {
  description = "TTL for DNS records in seconds"
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default     = {}
}