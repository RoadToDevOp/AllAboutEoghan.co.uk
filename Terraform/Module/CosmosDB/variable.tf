variable "account_name" {
  description = "The name of the CosmosDB account."
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "location" {
  description = "The Azure region to deploy CosmosDB."
  type        = string
}

variable "database_name" {
  description = "The name of the CosmosDB SQL database."
  type        = string
}

variable "container_name" {
  description = "The name of the CosmosDB SQL container."
  type        = string
}

variable "partition_key_path" {
  description = "The partition key path for the container (e.g., '/id')."
  type        = string
}

variable "database_throughput" {
  description = "The throughput for the CosmosDB SQL database (RU/s)."
  type        = number
  default     = 400
}

variable "container_throughput" {
  description = "The throughput for the CosmosDB SQL container (RU/s)."
  type        = number
  default     = null
}

variable "enable_automatic_failover" {
  description = "Enable automatic failover for the CosmosDB account."
  type        = bool
  default     = false
}

variable "consistency_level" {
  description = "The consistency level for the CosmosDB account."
  type        = string
  default     = "Session"
}

variable "max_interval_in_seconds" {
  description = "The max interval in seconds for Bounded Staleness consistency."
  type        = number
  default     = 5
}

variable "max_staleness_prefix" {
  description = "The max staleness prefix for Bounded Staleness consistency."
  type        = number
  default     = 100
}

variable "tags" {
  description = "A map of tags to assign to the resource."
  type        = map(string)
  default     = {}
}

