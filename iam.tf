resource "azurerm_user_assigned_identity" "app_identity" {
  name                = "id-secops-app-01"
  resource_group_name = azurerm_resource_group.sec_rg.name
  location            = azurerm_resource_group.sec_rg.location

  tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
resource "azurerm_role_assignment" "storage_reader" {
  scope                = azurerm_storage_account.secure_storage.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.app_identity.principal_id
}