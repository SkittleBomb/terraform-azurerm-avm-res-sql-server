resource "azurerm_mssql_outbound_firewall_rule" "this" {
  for_each = var.outbound_firewall_rule

  name      = each.value.name
  server_id = azurerm_mssql_server.this.id

  timeouts {
    create = try(each.value.timeouts.create, "30m")
    read   = try(each.value.timeouts.read, "5m")
    delete = try(each.value.timeouts.delete, "30m")
  }
}