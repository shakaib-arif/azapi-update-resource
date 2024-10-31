variable "update_resource_params" {
  type = map(object({
    type                    = string #Required
    body                    = any    #Required
    name                    = optional(string)
    parent_id               = optional(string)
    resource_id             = optional(string)
    response_export_values  = optional(list(string))
    locks                   = optional(list(string))
    ignore_casing           = optional(bool)
    ignore_missing_property = optional(bool)
  }))
}
