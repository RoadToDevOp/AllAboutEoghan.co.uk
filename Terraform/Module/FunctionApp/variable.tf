variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the Function App."
  type        = string
}

variable "function_app_name" {
  description = "The name of the Function App."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the existing storage account for the Function App."
  type        = string
}

variable "storage_account_access_key" {
  description = "The access key for the existing storage account."
  type        = string
  sensitive   = true
}

variable "service_plan_id" {
  description = "The ID of the existing App Service Plan."
  type        = string
}

variable "python_version" {
  description = "The Python version for the Function App."
  type        = string
  default     = "3.9"
}

variable "cosmos_endpoint" {
  description = "The endpoint of the Cosmos DB account."
  type        = string
}

variable "cosmos_key" {
  description = "The key of the Cosmos DB account."
  type        = string
  sensitive   = true
}

variable "cosmos_database" {
  description = "The name of the Cosmos DB database."
  type        = string
}

variable "cosmos_container" {
  description = "The name of the Cosmos DB container."
  type        = string
}

variable "cors_allowed_origins" {
  description = "List of origins allowed for CORS."
  type        = list(string)
  default     = ["*"]
}

variable "additional_app_settings" {
  description = "Additional app settings for the Function App."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}

variable "application_insights_name" {
  description = "The name of the Application Insights instance."
  type        = string
}

variable "application_insights_type" {
  description = "The type of Application Insights instance."
  type        = string
  default     = "web"
}

variable "application_insights_retention_days" {
  description = "The retention period in days for Application Insights data."
  type        = number
  default     = 90
}

