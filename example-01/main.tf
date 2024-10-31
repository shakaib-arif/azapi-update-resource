terraform {
  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.12.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

module "azapi" {
  source = "../azapi-update-resource"

  update_resource_params = {
    update_01 = {
      name        = null
      parent_id   = null
      resource_id = azurerm_lb.this.id
      type        = "Microsoft.Network/loadBalancers@2023-04-01"

      body = {
        properties = {
          inboundNatRules = [
            {
              properties = {
                idleTimeoutInMinutes = 15
              }
            }
          ]
        }
      }

      response_export_values  = null
      locks                   = null
      ignore_casing           = null
      ignore_missing_property = null
    }
  }

  depends_on = [
    azurerm_lb.this
  ]
}
