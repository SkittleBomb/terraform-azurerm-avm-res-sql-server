variable "server_extended_auditing_policy" {
  description = "Configuration for the SQL Server extended auditing policy"
  type = object({
    enabled                                 = optional(bool)
    storage_endpoint                        = optional(string)
    retention_in_days                       = optional(number)
    storage_account_access_key              = optional(string)
    storage_account_access_key_is_secondary = optional(bool)
    log_monitoring_enabled                  = optional(bool)
    storage_account_subscription_id         = optional(string)
    timeouts = optional(object({
      read   = string
      create = string
      update = string
      delete = string
    }))
  })
  default = {}
}
