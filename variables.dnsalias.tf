variable "dns_alias" {
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
Configuration for the MSSQL Server DNS Alias. This includes the following attributes:
- name: The name which should be used for this MSSQL Server DNS Alias. Changing this forces a new MSSQL Server DNS Alias to be created.
- timeouts: (Optional) A timeouts block as documented below.
EOF  
}
