variable "resource_group_name" {
  type        = string
  description = "The name of the secure resource group."
  default     = "rg-secops-dev-01"
}

variable "location" {
  type        = string
  description = "The Azure region for resource deployment."
  default     = "eastus"
}

variable "environment" {
  type        = string
  description = "Deployment environment tag."
  default     = "development"
}

variable "storage_account_name" {
  type        = string
  description = "Globally unique name for the secure storage account."
  default     = "stsecopsdev01unique"
}