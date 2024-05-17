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
      database_id            = "${module.sql_server.databases["db1"]["id"]}"
      log_monitoring_enabled = true
    },
    db2 = {
      enabled                = true
      database_id            = "${module.sql_server.databases["db2"]["id"]}"
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
      target_resource_id                       = "${module.sql_server.resource.id}/databases/master"
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
      target_resource_id                       = "${module.sql_server.databases["db1"]["id"]}"
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
      target_resource_id                       = "${module.sql_server.databases["db2"]["id"]}"
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

