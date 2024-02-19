resource "azurerm_mssql_virtual_network_rule" "this" {
  for_each = var.network_rule

  name                                 = each.value.name
  server_id                            = azurerm_mssql_server.this.id
  subnet_id                            = each.value.subnet_id
  ignore_missing_vnet_service_endpoint = each.value.ignore_missing_vnet_service_endpoint

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = try(timeouts.value.create, "30m")
      update = try(timeouts.value.update, "30m")
      delete = try(timeouts.value.delete, "30m")
      read   = try(timeouts.value.read, "5m")
    }
  }
}