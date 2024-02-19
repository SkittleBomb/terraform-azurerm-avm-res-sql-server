variable "network_rule" {
  type = map(object({
    name                                 = string
    subnet_id                            = string
    ignore_missing_vnet_service_endpoint = optional(bool)
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default     = {}
  description = <<EOF
Configuration for the Network Rule. This includes the following attributes:
- name: The name of the SQL virtual network rule. Changing this forces a new resource to be created.
- server_id: The resource ID of the SQL Server to which this SQL virtual network rule will be applied. Changing this forces a new resource to be created.
- subnet_id: The ID of the subnet from which the SQL server will accept communications.
- ignore_missing_vnet_service_endpoint: Create the virtual network rule before the subnet has the virtual network service endpoint enabled. Defaults to false.
- timeouts: (Optional) A timeouts block as documented below.
EOF
}