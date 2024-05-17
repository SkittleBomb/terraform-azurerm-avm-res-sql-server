variable "database_extended_auditing_policy" {
  type = map(object({
    enabled                                 = optional(bool, false)
    storage_endpoint                        = optional(string)
    retention_in_days                       = optional(number)
    storage_account_access_key              = optional(string)
    storage_account_access_key_is_secondary = optional(bool)
    log_monitoring_enabled                  = optional(bool)
    timeouts = optional(object({
      read   = string
      create = string
      update = string
      delete = string
    }))
  }))
  default     = {}
  description = <<EOF
Configuration for the SQL Database extended auditing policy. This includes the following attributes:
- enabled: (Optional) Whether to enable the extended auditing policy. Possible values are true and false. Defaults to true. If enabled is true, storage_endpoint or log_monitoring_enabled are required.
- storage_endpoint: (Optional) The blob storage endpoint (e.g. https://example.blob.core.windows.net). This blob storage will hold all extended auditing logs.
- retention_in_days: (Optional) The number of days to retain logs for in the storage account. Defaults to 0.
- storage_account_access_key: (Optional) The access key to use for the auditing storage account.
- storage_account_access_key_is_secondary: (Optional) Is storage_account_access_key value the storage's secondary key?
- log_monitoring_enabled: (Optional) Enable audit events to Azure Monitor? Defaults to true.
- timeouts: (Optional) A timeouts block as documented below.
EOF
}