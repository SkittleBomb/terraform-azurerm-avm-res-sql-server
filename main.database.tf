resource "azurerm_mssql_database" "this" {
  for_each = var.database

  name                 = each.value.name
  server_id            = azurerm_mssql_server.this.id
  create_mode          = each.value.create_mode
  collation            = each.value.collation
  elastic_pool_id      = each.value.elastic_pool_id
  geo_backup_enabled   = each.value.geo_backup_enabled
  ledger_enabled       = each.value.ledger_enabled
  license_type         = each.value.license_type
  max_size_gb          = each.value.max_size_gb
  min_capacity         = each.value.min_capacity
  read_replica_count   = each.value.read_replica_count
  read_scale           = each.value.read_scale
  sample_name          = each.value.sample_name
  sku_name             = each.value.sku_name
  storage_account_type = each.value.storage_account_type
  zone_redundant       = each.value.zone_redundant
  tags                 = each.value.tags

  dynamic "import" {
    for_each = each.value.import != null ? [each.value.import] : []
    content {
      storage_uri                  = import.value.storage_uri
      storage_key                  = import.value.storage_key
      storage_key_type             = import.value.storage_key_type
      administrator_login          = import.value.administrator_login
      administrator_login_password = import.value.administrator_login_password
      authentication_type          = import.value.authentication_type
      storage_account_id           = import.value.storage_account_id
    }
  }

  dynamic "long_term_retention_policy" {
    for_each = each.value.long_term_retention_policy != null ? [each.value.long_term_retention_policy] : []
    content {
      weekly_retention          = long_term_retention_policy.value.weekly_retention
      monthly_retention         = long_term_retention_policy.value.monthly_retention
      yearly_retention          = long_term_retention_policy.value.yearly_retention
      week_of_year              = long_term_retention_policy.value.week_of_year
      immutable_backups_enabled = long_term_retention_policy.value.immutable_backups_enabled
    }
  }

  dynamic "short_term_retention_policy" {
    for_each = each.value.short_term_retention_policy != null ? [each.value.short_term_retention_policy] : []
    content {
      retention_days           = short_term_retention_policy.value.retention_days
      backup_interval_in_hours = short_term_retention_policy.value.backup_interval_in_hours
    }
  }

  dynamic "threat_detection_policy" {
    for_each = each.value.threat_detection_policy != null ? [each.value.threat_detection_policy] : []
    content {
      state                      = threat_detection_policy.value.state
      disabled_alerts            = threat_detection_policy.value.disabled_alerts
      email_account_admins       = threat_detection_policy.value.email_account_admins
      email_addresses            = threat_detection_policy.value.email_addresses
      retention_days             = threat_detection_policy.value.retention_days
      storage_account_access_key = threat_detection_policy.value.storage_account_access_key
      storage_endpoint           = threat_detection_policy.value.storage_endpoint
    }
  }

  dynamic "identity" {
    for_each = each.value.identity != null ? [each.value.identity] : []
    content {
      type         = identity.value.type
      identity_ids = identity.value.identity_ids
    }
  }

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