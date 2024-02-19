variable "firewall_rule" {
  type = map(object({
    name             = string
    start_ip_address = string
    end_ip_address   = string
    timeouts = optional(object({
      create = optional(string)
      read   = optional(string)
      update = optional(string)
      delete = optional(string)
    }))
  }))
  default     = {}
  description = <<EOF
Configuration for the Firewall Rule. This includes the following attributes:
- name: The name of the firewall rule. Changing this forces a new resource to be created.
- start_ip_address: The starting IP address to allow through the firewall for this rule.
- end_ip_address: The ending IP address to allow through the firewall for this rule.
- timeouts: (Optional) A timeouts block as documented below.
EOF
}