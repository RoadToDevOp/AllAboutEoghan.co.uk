variable "function_app_name" {
  description = "The name of the Azure Function App"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources should be created"
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account for the function app"
  type        = string
}

variable "storage_account_access_key" {
  description = "The access key for the storage account"
  type        = string
  sensitive   = true
}

variable "cors_allowed_origins" {
  description = "List of origins that should be allowed to make cross-origin calls"
  type        = list(string)
  default     = ["*"]
}

variable "additional_app_settings" {
  description = "Additional app settings for the function app"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Additional tags to add to resources"
  type        = map(string)
  default     = {}
}
