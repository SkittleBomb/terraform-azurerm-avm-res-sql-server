variable "outbound_firewall_rule" {
  description = "Configuration for the outbound firewall rule"
  type = map(object({
    name = string
    timeouts = optional(object({
      create = string
      read   = string
      delete = string
    }))
  }))
  default = {}
}
