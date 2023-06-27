# Storage Account
resource "azurerm_storage_account" "storage" {
  count                    = var.num
  name                     = format("az%s-%s-sta%03d%s", var.project, var.environment, count.index + 1, var.name_suffix)
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
}