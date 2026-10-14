terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = true # Skips automatic provider registration to prevent network timeouts
}

# Secure Resource Group
resource "azurerm_resource_group" "sec_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    Environment      = var.environment
    ManagedBy        = "Terraform"
    SecurityBaseline = "CIS-Azure"
  }
}

# Secure Storage Account (Enforcing Encryption & Zero Public Access)
resource "azurerm_storage_account" "secure_storage" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.sec_rg.name
  location                 = azurerm_resource_group.sec_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  # Security Hardening Controls
  min_tls_version                 = "TLS1_2"
  https_traffic_only_enabled      = true
  public_network_access_enabled   = false
  allow_nested_items_to_be_public = false

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = {
    Environment    = var.environment
    SecurityStatus = "Hardened"
  }
}