<!-- BEGIN_TF_DOCS -->
# Server Extended Auditing Policy example

Manages a MS SQL Server Extended Auditing Policy.

```hcl
terraform {
  required_version = ">= 1.3.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0, < 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.0, < 4.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}


## Section to provide a random Azure region for the resource group
# This allows us to randomize the region for the resource group.
module "regions" {
  source  = "Azure/regions/azurerm"
  version = ">= 0.3.0"
}

# This allows us to randomize the region for the resource group.
resource "random_integer" "region_index" {
  min = 0
  max = length(module.regions.regions) - 1
}
## End of section to provide a random Azure region for the resource group

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = ">= 0.3.0"
}

# This is required for resource modules
resource "azurerm_resource_group" "this" {
  name     = module.naming.resource_group.name_unique
  location = module.regions.regions[random_integer.region_index.result].name
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = module.naming.log_analytics_workspace.name_unique
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

# This is the module call
# Do not specify location here due to the randomization above.
# Leaving location as `null` will cause the module to use the resource group location
# with a data source.
module "sql_server" {
  source = "../../"

  sqlserver_name      = module.naming.sql_server.name_unique
  resource_group_name = azurerm_resource_group.this.name

  server_extended_auditing_policy = {
    enabled                = true
    log_monitoring_enabled = true
  }

  database_extended_auditing_policy = {
    db1 = {
      enabled                = true
      log_monitoring_enabled = true
    },
    db2 = {
      enabled                = true
      log_monitoring_enabled = true
    }
  }

  database = {
    db1 = {
      name         = module.naming.mssql_database.name_unique
      collation    = "SQL_Latin1_General_CP1_CI_AS"
      license_type = "LicenseIncluded"
      sku_name     = "S0"
    },
    db2 = {
      name         = "${module.naming.mssql_database.name_unique}1"
      collation    = "SQL_Latin1_General_CP1_CI_AS"
      license_type = "LicenseIncluded"
      sku_name     = "S0"
    }
  }



  diagnostic_settings = {
    diagnostic_settings1 = {
      name                                     = module.naming.monitor_diagnostic_setting.name_unique
      workspace_resource_id                    = azurerm_log_analytics_workspace.this.id
      log_categories                           = ["SQLSecurityAuditEvents"]
      log_groups                               = []
      metric_categories                        = ["Basic", "InstanceAndAppAdvanced", "WorkloadManagement"]
      storage_account_resource_id              = null
      event_hub_authorization_rule_resource_id = null
      event_hub_name                           = null
      marketplace_partner_resource_id          = null
    },
    diagnostic_settings2 = {
      name                                     = module.naming.monitor_diagnostic_setting.name_unique
      service_type                             = "databases/${module.naming.mssql_database.name_unique}"
      workspace_resource_id                    = azurerm_log_analytics_workspace.this.id
      log_categories                           = ["SQLSecurityAuditEvents"]
      log_groups                               = []
      metric_categories                        = ["Basic", "InstanceAndAppAdvanced", "WorkloadManagement"]
      storage_account_resource_id              = null
      event_hub_authorization_rule_resource_id = null
      event_hub_name                           = null
      marketplace_partner_resource_id          = null
    },
    diagnostic_settings3 = {
      name                                     = module.naming.monitor_diagnostic_setting.name_unique
      service_type                             = "databases/${module.naming.mssql_database.name_unique}1"
      workspace_resource_id                    = azurerm_log_analytics_workspace.this.id
      log_categories                           = ["SQLSecurityAuditEvents"]
      log_groups                               = []
      metric_categories                        = ["Basic", "InstanceAndAppAdvanced", "WorkloadManagement"]
      storage_account_resource_id              = null
      event_hub_authorization_rule_resource_id = null
      event_hub_name                           = null
      marketplace_partner_resource_id          = null
    }
  }
}

```

<!-- markdownlint-disable MD033 -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 1.3.0)

- <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) (>= 3.7.0, < 4.0.0)

- <a name="requirement_random"></a> [random](#requirement\_random) (>= 3.5.0, < 4.0.0)

## Providers

The following providers are used by this module:

- <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) (>= 3.7.0, < 4.0.0)

- <a name="provider_random"></a> [random](#provider\_random) (>= 3.5.0, < 4.0.0)

## Resources

The following resources are used by this module:

- [azurerm_log_analytics_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace) (resource)
- [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) (resource)
- [random_integer.region_index](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/integer) (resource)

<!-- markdownlint-disable MD013 -->
## Required Inputs

No required inputs.

## Optional Inputs

No optional inputs.

## Outputs

No outputs.

## Modules

The following Modules are called:

### <a name="module_naming"></a> [naming](#module\_naming)

Source: Azure/naming/azurerm

Version: >= 0.3.0

### <a name="module_regions"></a> [regions](#module\_regions)

Source: Azure/regions/azurerm

Version: >= 0.3.0

### <a name="module_sql_server"></a> [sql\_server](#module\_sql\_server)

Source: ../../

Version:

<!-- markdownlint-disable-next-line MD041 -->
## Data Collection

The software may collect information about you and your use of the software and send it to Microsoft. Microsoft may use this information to provide services and improve our products and services. You may turn off the telemetry as described in the repository. There are also some features in the software that may enable you and Microsoft to collect data from users of your applications. If you use these features, you must comply with applicable law, including providing appropriate notices to users of your applications together with a copy of Microsoft’s privacy statement. Our privacy statement is located at <https://go.microsoft.com/fwlink/?LinkID=824704>. You can learn more about data collection and use in the help documentation and our privacy statement. Your use of the software operates as your consent to these practices.
<!-- END_TF_DOCS -->