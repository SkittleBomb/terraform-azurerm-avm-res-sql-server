resource "azurerm_mssql_server_extended_auditing_policy" "this" {
  server_id                               = azurerm_mssql_server.this.id
  enabled                                 = var.server_extended_auditing_policy.enabled
  storage_endpoint                        = var.server_extended_auditing_policy.storage_endpoint
  retention_in_days                       = var.server_extended_auditing_policy.retention_in_days
  storage_account_access_key              = var.server_extended_auditing_policy.storage_account_access_key
  storage_account_access_key_is_secondary = var.server_extended_auditing_policy.storage_account_access_key_is_secondary
  log_monitoring_enabled                  = var.server_extended_auditing_policy.log_monitoring_enabled
  storage_account_subscription_id         = var.server_extended_auditing_policy.storage_account_subscription_id

  dynamic "timeouts" {
    for_each = var.server_extended_auditing_policy.timeouts != null ? [var.server_extended_auditing_policy.timeouts] : []
    content {
      create = try(timeouts.value.create, "30m")
      update = try(timeouts.value.update, "30m")
      delete = try(timeouts.value.delete, "30m")
      read   = try(timeouts.value.read, "5m")
    }
  }
}
