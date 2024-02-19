variable "outbound_firewall_rule" {
  type = map(object({
    name = string
    timeouts = optional(object({
      create = string
      read   = string
      delete = string
    }))
  }))
  default     = {}
  description = <<EOF
Configuration for the outbound firewall rule. This includes the following attributes:
- name: The name which should be used for this Outbound Firewall Rule. Changing this forces a new Outbound Firewall Rule to be created.
- timeouts: (Optional) A timeouts block as documented below.
EOF
}
