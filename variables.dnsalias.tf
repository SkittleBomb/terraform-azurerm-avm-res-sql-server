variable "dns_alias" {
  description = "Configuration for the MSSQL Server DNS Alias"
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
