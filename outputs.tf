output "resource" {
  value       = azurerm_mssql_server.this
  description = "This is the full output for the resource."
}

output "private_endpoints" {
  value       = azurerm_private_endpoint.this
  description = "A map of private endpoints. The map key is the supplied input to var.private_endpoints. The map value is the entire azurerm_private_endpoint resource."
}

output "sql_admin_password" {
  value     = local.admin_password
  sensitive = true
}

output "outbound_firewall_rule_ids" {
  description = "The IDs of the MSSQL outbound firewall rules"
  value       = { for key, rule in azurerm_mssql_outbound_firewall_rule.this : key => rule.id }
}

output "auditing_policy_ids" {
  description = "The IDs of the SQL Server extended auditing policies"
  value       = azurerm_mssql_server_extended_auditing_policy.this
}

output "dns_aliases" {
  description = "The IDs and DNS records of the MSSQL Server DNS Aliases"
  value = {
    for key, alias in azurerm_mssql_server_dns_alias.this :
    key => {
      id         = alias.id
      dns_record = alias.dns_record
    }
  }
}

output "databases" {
  value       = azurerm_mssql_database.this
  description = "This is the full output for the databases."
}


