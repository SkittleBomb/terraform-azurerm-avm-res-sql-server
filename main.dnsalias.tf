resource "azurerm_mssql_server_dns_alias" "this" {
  for_each = var.dns_alias

  name            = each.value.name
  mssql_server_id = azurerm_mssql_server.this.id

  timeouts {
    create = try(each.value.timeouts.create, "30m")
    read   = try(each.value.timeouts.read, "5m")
    delete = try(each.value.timeouts.delete, "30m")
  }
}