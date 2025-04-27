variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the storage account."
  type        = string
}

variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "account_tier" {
  description = "The storage account tier (Standard or Premium)."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "The storage account replication type (LRS, GRS, RAGRS, ZRS)."
  type        = string
  default     = "LRS"
}

variable "account_kind" {
  description = "The type of storage account (StorageV2, BlobStorage, etc)."
  type        = string
  default     = "StorageV2"
}

variable "enable_https_traffic_only" {
  description = "Boolean flag which forces HTTPS if enabled."
  type        = bool
  default     = true
}

variable "min_tls_version" {
  description = "The minimum supported TLS version for the storage account."
  type        = string
  default     = "TLS1_2"
}

variable "enable_blob_encryption" {
  description = "Boolean flag which enables blob encryption at rest."
  type        = bool
  default     = true
}

variable "enable_file_encryption" {
  description = "Boolean flag which enables file encryption at rest."
  type        = bool
  default     = true
}

variable "enable_table_encryption" {
  description = "Boolean flag which enables table encryption at rest."
  type        = bool
  default     = true
}

variable "enable_queue_encryption" {
  description = "Boolean flag which enables queue encryption at rest."
  type        = bool
  default     = true
}

variable "network_rules" {
  description = "Network rules to apply to the storage account."
  type = object({
    default_action             = string
    ip_rules                   = list(string)
    virtual_network_subnet_ids = list(string)
    bypass                     = list(string)
  })
  default = {
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = []
    bypass                     = ["AzureServices"]
  }
}

variable "tags" {
  description = "A map of tags to assign to the storage account."
  type        = map(string)
  default     = {}
}

