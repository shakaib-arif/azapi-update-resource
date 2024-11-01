resource "azapi_update_resource" "this" {
  for_each                = { for idx, value in var.update_resource_params : idx => value }
  resource_id             = each.value.resource_id != null ? each.value.resource_id : provider::azapi::build_resource_id(each.value.parent_id, each.value.type, each.value.name)
  type                    = each.value.type # Required
  body                    = each.value.body # Required
  response_export_values  = each.value.response_export_values
  locks                   = each.value.locks
  ignore_casing           = each.value.ignore_casing
  ignore_missing_property = each.value.ignore_missing_property
}
