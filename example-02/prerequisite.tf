provider "azurerm" {
  features {}
  subscription_id = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" # TODO: Add your subscription ID 
}

provider "azapi" {}

locals {
  region          = "westeurope"
  resource_group  = "RG_DEV_DEMO" # TODO: Add you resource group name
  resource_prefix = "we-dev-demo-azapi"
}

data "azurerm_resource_group" "this" {
  name = local.resource_group
}

resource "azurerm_user_assigned_identity" "this" {
  name                = "${local.resource_prefix}-uai-02"
  resource_group_name = local.resource_group
  location            = local.region
}

resource "azurerm_lb" "this" {
  name                = "${local.resource_prefix}-lb-02"
  resource_group_name = local.resource_group
  location            = local.region
  sku                 = "Standard"
  sku_tier            = "Regional"

  frontend_ip_configuration {
    name = "frontend_ip_conf_02"
  }
}

resource "azurerm_lb_nat_rule" "this" {
  loadbalancer_id                = azurerm_lb.this.id
  name                           = "${local.resource_prefix}-lbnat-rule-02"
  resource_group_name            = local.resource_group
  backend_port                   = 3389
  enable_floating_ip             = false
  enable_tcp_reset               = false
  frontend_ip_configuration_name = "frontend_ip_conf_02"
  frontend_port                  = 3389
  idle_timeout_in_minutes        = 4
  protocol                       = "Tcp"
}

resource "azurerm_public_ip" "this" {
  name                    = "${local.resource_prefix}-pip-02"
  resource_group_name     = local.resource_group
  location                = local.region
  allocation_method       = "Static"
  ddos_protection_mode    = "VirtualNetworkInherited"
  idle_timeout_in_minutes = 4
  ip_version              = "IPv4"
  sku                     = "Standard"
  sku_tier                = "Regional"
}
