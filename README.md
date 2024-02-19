<!-- BEGIN_TF_DOCS -->
# terraform-azurerm-avm-res-sql-server

Manages a Microsoft SQL Azure Database Server.

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.6.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.71.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.5.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>= 3.71.0)

- <a name="provider_random"></a> [random](#provider\_random) (>= 3.5.0)

## Resources

The following resources are used by this module:

- [azurerm_management_lock.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) (resource)
- [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) (resource)
- [azurerm_mssql_database.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_database) (resource)
- [azurerm_mssql_outbound_firewall_rule.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_outbound_firewall_rule) (resource)
- [azurerm_mssql_server.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server) (resource)
- [azurerm_mssql_server_dns_alias.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_dns_alias) (resource)
- [azurerm_mssql_server_extended_auditing_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server_extended_auditing_policy) (resource)
- [azurerm_private_endpoint.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) (resource)
- [azurerm_private_endpoint_application_security_group_association.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint_application_security_group_association) (resource)
- [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) (resource)
- [random_password.main](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) (resource)
- [azurerm_resource_group.parent](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) (data source)

<!-- markdownlint-disable MD013 -->
## Required Inputs

The following input variables are required:

### <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name)

Description: The resource group where the resources will be deployed.

Type: `string`

### <a name="input_sqlserver_name"></a> [sqlserver\_name](#input\_sqlserver\_name)

Description: The name of this resource.

Type: `string`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_administrator_login"></a> [administrator\_login](#input\_administrator\_login)

Description: The administrator login name for the new server. Required unless azuread\_authentication\_only in the azuread\_administrator block is true. When omitted, Azure will generate a default username which cannot be subsequently changed. Changing this forces a new resource to be created.

Type: `string`

Default: `null`

### <a name="input_administrator_login_password"></a> [administrator\_login\_password](#input\_administrator\_login\_password)

Description: The password associated with the administrator\_login user. Needs to comply with Azure's Password Policy. Required unless azuread\_authentication\_only in the azuread\_administrator block is true.

Type: `string`

Default: `null`

### <a name="input_azuread_administrator"></a> [azuread\_administrator](#input\_azuread\_administrator)

Description: The Azure AD administrator block for the Azure SQL Server.

Type:

```hcl
object({
    login_username              = string
    object_id                   = string
    tenant_id                   = optional(string)
    azuread_authentication_only = optional(bool)
  })
```

Default: `null`

### <a name="input_connection_policy"></a> [connection\_policy](#input\_connection\_policy)

Description: The connection policy for the Azure SQL Server.

Type: `string`

Default: `"Default"`

### <a name="input_customer_managed_key"></a> [customer\_managed\_key](#input\_customer\_managed\_key)

Description: Customer managed keys that should be associated with the resource.

Type:

```hcl
object({
    key_vault_resource_id              = optional(string)
    key_name                           = optional(string)
    key_version                        = optional(string, null)
    user_assigned_identity_resource_id = optional(string, null)
  })
```

Default: `{}`

### <a name="input_database"></a> [database](#input\_database)

Description: Configuration for the MS SQL Database. This includes the following attributes:
- name: The name of the MS SQL Database.
- server\_id: The id of the MS SQL Server on which to create the database.
- create\_mode: The create mode of the database. Possible values are Copy, Default, OnlineSecondary, PointInTimeRestore, Recovery, Restore, RestoreExternalBackup, RestoreExternalBackupSecondary, RestoreLongTermRetentionBackup and Secondary. Defaults to Default.
- import: A import block as documented below.
- creation\_source\_database\_id: The ID of the source database from which to create the new database.
- collation: Specifies the collation of the database.
- elastic\_pool\_id: Specifies the ID of the elastic pool containing this database.
- enclave\_type: Specifies the type of enclave to be used by the database.
- geo\_backup\_enabled: A boolean that specifies if the Geo Backup Policy is enabled.
- maintenance\_configuration\_name: The name of the Public Maintenance Configuration window to apply to the database.
- ledger\_enabled: A boolean that specifies if this is a ledger database.
- license\_type: Specifies the license type applied to this database.
- long\_term\_retention\_policy: A long\_term\_retention\_policy block as defined below.
- max\_size\_gb: The max size of the database in gigabytes.
- min\_capacity: Minimal capacity that database will always have allocated, if not paused.
- restore\_point\_in\_time: Specifies the point in time (ISO8601 format) of the source database that will be restored to create the new database.
- recover\_database\_id: The ID of the database to be recovered.
- restore\_dropped\_database\_id: The ID of the database to be restored.
- read\_replica\_count: The number of readonly secondary replicas associated with the database to which readonly application intent connections may be routed.
- read\_scale: If enabled, connections that have application intent set to readonly in their connection string may be routed to a readonly secondary replica.
- sample\_name: Specifies the name of the sample schema to apply when creating this database.
- short\_term\_retention\_policy: A short\_term\_retention\_policy block as defined below.
- sku\_name: Specifies the name of the SKU used by the database.
- storage\_account\_type: Specifies the storage account type used to store backups for this database.
- threat\_detection\_policy: Threat detection policy configuration.
- identity: An identity block as defined below.
- transparent\_data\_encryption\_enabled: If set to true, Transparent Data Encryption will be enabled on the database.
- transparent\_data\_encryption\_key\_vault\_key\_id: The fully versioned Key Vault Key URL to be used as the Customer Managed Key for the Transparent Data Encryption layer.
- transparent\_data\_encryption\_key\_automatic\_rotation\_enabled: Boolean flag to specify whether TDE automatically rotates the encryption Key to latest version or not.
- zone\_redundant: Whether or not this database is zone redundant.
- tags: A mapping of tags to assign to the resource.
- timeouts: (Optional) A timeouts block as documented below.

Type:

```hcl
map(object({
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
```

Default: `{}`

### <a name="input_diagnostic_settings"></a> [diagnostic\_settings](#input\_diagnostic\_settings)

Description: A map of diagnostic settings to create. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the diagnostic setting. One will be generated if not set, however this will not be unique if you want to create multiple diagnostic setting resources.
- `log_categories` - (Optional) A set of log categories to send to the log analytics workspace. Defaults to `[]`.
- `log_groups` - (Optional) A set of log groups to send to the log analytics workspace. Defaults to `["allLogs"]`.
- `metric_categories` - (Optional) A set of metric categories to send to the log analytics workspace. Defaults to `["AllMetrics"]`.
- `log_analytics_destination_type` - (Optional) The destination type for the diagnostic setting. Possible values are `Dedicated` and `AzureDiagnostics`. Defaults to `Dedicated`.
- `workspace_resource_id` - (Optional) The resource ID of the log analytics workspace to send logs and metrics to.
- `storage_account_resource_id` - (Optional) The resource ID of the storage account to send logs and metrics to.
- `event_hub_authorization_rule_resource_id` - (Optional) The resource ID of the event hub authorization rule to send logs and metrics to.
- `event_hub_name` - (Optional) The name of the event hub. If none is specified, the default event hub will be selected.
- `marketplace_partner_resource_id` - (Optional) The full ARM resource ID of the Marketplace resource to which you would like to send Diagnostic LogsLogs.

Type:

```hcl
map(object({
    name                                     = optional(string, null)
    log_categories                           = optional(set(string), [])
    log_groups                               = optional(set(string), [])
    metric_categories                        = optional(set(string), ["AllMetrics"])
    log_analytics_destination_type           = optional(string, "Dedicated")
    workspace_resource_id                    = optional(string, null)
    storage_account_resource_id              = optional(string, null)
    event_hub_authorization_rule_resource_id = optional(string, null)
    event_hub_name                           = optional(string, null)
    marketplace_partner_resource_id          = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_dns_alias"></a> [dns\_alias](#input\_dns\_alias)

Description: Configuration for the MSSQL Server DNS Alias. This includes the following attributes:
- name: The name which should be used for this MSSQL Server DNS Alias. Changing this forces a new MSSQL Server DNS Alias to be created.
- timeouts: (Optional) A timeouts block as documented below.

Type:

```hcl
map(object({
    name = string
    timeouts = optional(object({
      create = string
      read   = string
      delete = string
    }))
  }))
```

Default: `{}`

### <a name="input_identity"></a> [identity](#input\_identity)

Description: The identity block for the Azure SQL Server.

Type:

```hcl
object({
    type         = string
    identity_ids = list(string)
  })
```

Default:

```json
{
  "identity_ids": [],
  "type": "SystemAssigned"
}
```

### <a name="input_location"></a> [location](#input\_location)

Description: Azure region where the resource should be deployed.  If null, the location will be inferred from the resource group location.

Type: `string`

Default: `null`

### <a name="input_lock"></a> [lock](#input\_lock)

Description: The lock level to apply. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.

Type:

```hcl
object({
    name = optional(string, null)
    kind = optional(string, "None")
  })
```

Default: `{}`

### <a name="input_managed_identities"></a> [managed\_identities](#input\_managed\_identities)

Description: Managed identities to be created for the resource.

Type:

```hcl
object({
    system_assigned            = optional(bool, false)
    user_assigned_resource_ids = optional(set(string), [])
  })
```

Default: `{}`

### <a name="input_minimum_tls_version"></a> [minimum\_tls\_version](#input\_minimum\_tls\_version)

Description: The minimum TLS version for the Azure SQL Server.

Type: `string`

Default: `"1.2"`

### <a name="input_outbound_firewall_rule"></a> [outbound\_firewall\_rule](#input\_outbound\_firewall\_rule)

Description: Configuration for the outbound firewall rule. This includes the following attributes:
- name: The name which should be used for this Outbound Firewall Rule. Changing this forces a new Outbound Firewall Rule to be created.
- timeouts: (Optional) A timeouts block as documented below.

Type:

```hcl
map(object({
    name = string
    timeouts = optional(object({
      create = string
      read   = string
      delete = string
    }))
  }))
```

Default: `{}`

### <a name="input_outbound_network_restriction_enabled"></a> [outbound\_network\_restriction\_enabled](#input\_outbound\_network\_restriction\_enabled)

Description: Whether outbound network restriction is enabled for the Azure SQL Server.

Type: `bool`

Default: `true`

### <a name="input_primary_user_assigned_identity_id"></a> [primary\_user\_assigned\_identity\_id](#input\_primary\_user\_assigned\_identity\_id)

Description: The ID of the primary user assigned identity for the Azure SQL Server.

Type: `string`

Default: `null`

### <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints)

Description: A map of private endpoints to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `name` - (Optional) The name of the private endpoint. One will be generated if not set.
- `role_assignments` - (Optional) A map of role assignments to create on the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time. See `var.role_assignments` for more information.
- `lock` - (Optional) The lock level to apply to the private endpoint. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`.
- `tags` - (Optional) A mapping of tags to assign to the private endpoint.
- `subnet_resource_id` - The resource ID of the subnet to deploy the private endpoint in.
- `private_dns_zone_group_name` - (Optional) The name of the private DNS zone group. One will be generated if not set.
- `private_dns_zone_resource_ids` - (Optional) A set of resource IDs of private DNS zones to associate with the private endpoint. If not set, no zone groups will be created and the private endpoint will not be associated with any private DNS zones. DNS records must be managed external to this module.
- `application_security_group_resource_ids` - (Optional) A map of resource IDs of application security groups to associate with the private endpoint. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
- `private_service_connection_name` - (Optional) The name of the private service connection. One will be generated if not set.
- `network_interface_name` - (Optional) The name of the network interface. One will be generated if not set.
- `location` - (Optional) The Azure location where the resources will be deployed. Defaults to the location of the resource group.
- `resource_group_name` - (Optional) The resource group where the resources will be deployed. Defaults to the resource group of this resource.
- `ip_configurations` - (Optional) A map of IP configurations to create on the private endpoint. If not specified the platform will create one. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.
  - `name` - The name of the IP configuration.
  - `private_ip_address` - The private IP address of the IP configuration.

Type:

```hcl
map(object({
    name = optional(string, null)
    role_assignments = optional(map(object({
      role_definition_id_or_name             = string
      principal_id                           = string
      description                            = optional(string, null)
      skip_service_principal_aad_check       = optional(bool, false)
      condition                              = optional(string, null)
      condition_version                      = optional(string, null)
      delegated_managed_identity_resource_id = optional(string, null)
    })), {})
    lock = optional(object({
      name = optional(string, null)
      kind = optional(string, "None")
    }), {})
    tags                                    = optional(map(any), null)
    subnet_resource_id                      = string
    private_dns_zone_group_name             = optional(string, "default")
    private_dns_zone_resource_ids           = optional(set(string), [])
    application_security_group_associations = optional(map(string), {})
    private_service_connection_name         = optional(string, null)
    network_interface_name                  = optional(string, null)
    location                                = optional(string, null)
    resource_group_name                     = optional(string, null)
    ip_configurations = optional(map(object({
      name               = string
      private_ip_address = string
    })), {})
  }))
```

Default: `{}`

### <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled)

Description: Whether public network access is enabled for the Azure SQL Server.

Type: `bool`

Default: `false`

### <a name="input_random_password_length"></a> [random\_password\_length](#input\_random\_password\_length)

Description: The desired length of random password created by this module

Type: `number`

Default: `32`

### <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments)

Description: A map of role assignments to create on this resource. The map key is deliberately arbitrary to avoid issues where map keys maybe unknown at plan time.

- `role_definition_id_or_name` - The ID or name of the role definition to assign to the principal.
- `principal_id` - The ID of the principal to assign the role to.
- `description` - The description of the role assignment.
- `skip_service_principal_aad_check` - If set to true, skips the Azure Active Directory check for the service principal in the tenant. Defaults to false.
- `condition` - The condition which will be used to scope the role assignment.
- `condition_version` - The version of the condition syntax. Valid values are '2.0'.

> Note: only set `skip_service_principal_aad_check` to true if you are assigning a role to a service principal.

Type:

```hcl
map(object({
    role_definition_id_or_name             = string
    principal_id                           = string
    description                            = optional(string, null)
    skip_service_principal_aad_check       = optional(bool, false)
    condition                              = optional(string, null)
    condition_version                      = optional(string, null)
    delegated_managed_identity_resource_id = optional(string, null)
  }))
```

Default: `{}`

### <a name="input_server_extended_auditing_policy"></a> [server\_extended\_auditing\_policy](#input\_server\_extended\_auditing\_policy)

Description: Configuration for the SQL Server extended auditing policy. This includes the following attributes:
- enabled: (Optional) Whether to enable the extended auditing policy. Possible values are true and false. Defaults to true. If enabled is true, storage\_endpoint or log\_monitoring\_enabled are required.
- storage\_endpoint: (Optional) The blob storage endpoint (e.g. https://example.blob.core.windows.net). This blob storage will hold all extended auditing logs.
- retention\_in\_days: (Optional) The number of days to retain logs for in the storage account. Defaults to 0.
- storage\_account\_access\_key: (Optional) The access key to use for the auditing storage account.
- storage\_account\_access\_key\_is\_secondary: (Optional) Is storage\_account\_access\_key value the storage's secondary key?
- log\_monitoring\_enabled: (Optional) Enable audit events to Azure Monitor? To enable server audit events to Azure Monitor, please enable its main database audit events to Azure Monitor. Defaults to true.
- storage\_account\_subscription\_id: (Optional) The ID of the Subscription containing the Storage Account.
- timeouts: (Optional) A timeouts block as documented below.

Type:

```hcl
object({
    enabled                                 = optional(bool, false)
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
```

Default: `{}`

### <a name="input_sql_version"></a> [sql\_version](#input\_sql\_version)

Description: The version of the Azure SQL Server.

Type: `string`

Default: `"12.0"`

### <a name="input_tags"></a> [tags](#input\_tags)

Description: The map of tags to be applied to the resource

Type: `map(any)`

Default: `{}`

### <a name="input_timeouts"></a> [timeouts](#input\_timeouts)

Description: The timeouts block for the Azure SQL Server.

Type:

```hcl
object({
    create = string
    update = string
    read   = string
    delete = string
  })
```

Default:

```json
{
  "create": "30m",
  "delete": "30m",
  "read": "5m",
  "update": "30m"
}
```

### <a name="input_transparent_data_encryption_key_vault_key_id"></a> [transparent\_data\_encryption\_key\_vault\_key\_id](#input\_transparent\_data\_encryption\_key\_vault\_key\_id)

Description: The ID of the Key Vault key used for Transparent Data Encryption.

Type: `string`

Default: `null`

## Outputs

The following outputs are exported:

### <a name="output_auditing_policy_ids"></a> [auditing\_policy\_ids](#output\_auditing\_policy\_ids)

Description: The IDs of the SQL Server extended auditing policies

### <a name="output_dns_aliases"></a> [dns\_aliases](#output\_dns\_aliases)

Description: The IDs and DNS records of the MSSQL Server DNS Aliases

### <a name="output_outbound_firewall_rule_ids"></a> [outbound\_firewall\_rule\_ids](#output\_outbound\_firewall\_rule\_ids)

Description: The IDs of the MSSQL outbound firewall rules

### <a name="output_private_endpoints"></a> [private\_endpoints](#output\_private\_endpoints)

Description: A map of private endpoints. The map key is the supplied input to var.private\_endpoints. The map value is the entire azurerm\_private\_endpoint resource.

### <a name="output_resource"></a> [resource](#output\_resource)

Description: This is the full output for the resource.

### <a name="output_sql_admin_password"></a> [sql\_admin\_password](#output\_sql\_admin\_password)

Description: n/a

## Modules

No modules.

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->