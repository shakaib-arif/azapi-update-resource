resource "azapi_update_resource" "this" {
  for_each                = var.update_resource_params
  name                    = each.value.name      # null
  parent_id               = each.value.parent_id # null
  resource_id             = each.value.resource_id
  type                    = each.value.type # Required
  body                    = each.value.body # Required
  response_export_values  = each.value.response_export_values
  locks                   = each.value.locks
  ignore_casing           = each.value.ignore_casing
  ignore_missing_property = each.value.ignore_missing_property
}
