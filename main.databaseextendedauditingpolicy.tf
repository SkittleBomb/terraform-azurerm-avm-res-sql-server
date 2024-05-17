resource "azurerm_mssql_database_extended_auditing_policy" "this" {
  for_each = var.database_extended_auditing_policy

  database_id                             = azurerm_mssql_database.this[each.key].id
  enabled                                 = each.value.enabled
  storage_endpoint                        = each.value.storage_endpoint
  retention_in_days                       = each.value.retention_in_days
  storage_account_access_key              = each.value.storage_account_access_key
  storage_account_access_key_is_secondary = each.value.storage_account_access_key_is_secondary
  log_monitoring_enabled                  = each.value.log_monitoring_enabled

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = try(timeouts.value.create, "30m")
      read   = try(timeouts.value.read, "5m")
      update = try(timeouts.value.update, "30m")
      delete = try(timeouts.value.delete, "30m")
    }
  }
}