variable "database" {
  type = map(object({
    name                        = string
    auto_pause_delay_in_minutes = optional(number)
    create_mode                 = optional(string)
    import = optional(list(object({
      storage_uri                  = string
      storage_key                  = string
      storage_key_type             = string
      administrator_login          = string
      administrator_login_password = string
      authentication_type          = string
      storage_account_id           = optional(string)
    })))
    creation_source_database_id    = optional(string)
    collation                      = optional(string)
    elastic_pool_id                = optional(string)
    enclave_type                   = optional(string)
    geo_backup_enabled             = optional(bool)
    maintenance_configuration_name = optional(string)
    ledger_enabled                 = optional(bool)
    license_type                   = optional(string)
    long_term_retention_policy = optional(object({
      weekly_retention          = string
      monthly_retention         = string
      yearly_retention          = string
      week_of_year              = number
      immutable_backups_enabled = bool
    }))
    max_size_gb                 = optional(number)
    min_capacity                = optional(number)
    restore_point_in_time       = optional(string)
    recover_database_id         = optional(string)
    restore_dropped_database_id = optional(string)
    read_replica_count          = optional(number)
    read_scale                  = optional(bool)
    sample_name                 = optional(string)
    short_term_retention_policy = optional(object({
      retention_days           = number
      backup_interval_in_hours = optional(number)
    }))
    sku_name             = optional(string)
    storage_account_type = optional(string)
    threat_detection_policy = optional(object({
      state                      = string
      disabled_alerts            = list(string)
      email_account_admins       = string
      email_addresses            = list(string)
      retention_days             = number
      storage_account_access_key = string
      storage_endpoint           = string
    }))
    identity = optional(object({
      type         = string
      identity_ids = list(string)
    }))
    transparent_data_encryption_enabled                        = optional(bool)
    transparent_data_encryption_key_vault_key_id               = optional(string)
    transparent_data_encryption_key_automatic_rotation_enabled = optional(bool)
    zone_redundant                                             = optional(bool)
    tags                                                       = optional(map(string))
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default     = {}
  description = <<EOF
Configuration for the MS SQL Database. This includes the following attributes:
- name: The name of the MS SQL Database.
- server_id: The id of the MS SQL Server on which to create the database.
- create_mode: The create mode of the database. Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary. Defaults to Default.
- import: A import block as documented below.
- creation_source_database_id: The ID of the source database from which to create the new database.
- collation: Specifies the collation of the database.
- elastic_pool_id: Specifies the ID of the elastic pool containing this database.
- enclave_type: Specifies the type of enclave to be used by the database.
- geo_backup_enabled: A boolean that specifies if the Geo Backup Policy is enabled.
- maintenance_configuration_name: The name of the Public Maintenance Configuration window to apply to the database.
- ledger_enabled: A boolean that specifies if this is a ledger database.
- license_type: Specifies the license type applied to this database.
- long_term_retention_policy: A long_term_retention_policy block as defined below.
- max_size_gb: The max size of the database in gigabytes.
- min_capacity: Minimal capacity that database will always have allocated, if not paused.
- restore_point_in_time: Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
- recover_database_id: The ID of the database to be recovered.
- restore_dropped_database_id: The ID of the database to be restored.
- read_replica_count: The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed.
- read_scale: If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica.
- sample_name: Specifies the name of the sample schema to apply when creating this database.
- short_term_retention_policy: A short_term_retention_policy block as defined below.
- sku_name: Specifies the name of the SKU used by the database.
- storage_account_type: Specifies the storage account type used to store backups for this database.
- threat_detection_policy: Threat detection policy configuration.
- identity: An identity block as defined below.
- transparent_data_encryption_enabled: If set to true, Transparent Data Encryption will be enabled on the database.
- transparent_data_encryption_key_vault_key_id: The fully versioned Key Vault Key URL to be used as the Customer Managed Key for the Transparent Data Encryption layer.
- transparent_data_encryption_key_automatic_rotation_enabled: Boolean flag to specify whether TDE automatically rotates the encryption Key to latest version or not.
- zone_redundant: Whether or not this database is zone redundant.
- tags: A mapping of tags to assign to the resource.
- timeouts: (Optional) A timeouts block as documented below.
EOF
}