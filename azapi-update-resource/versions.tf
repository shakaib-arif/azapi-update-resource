terraform {
  required_version = ">= 0.15.0"


  required_providers {
    azapi = {
      source  = "azure/azapi"
      version = ">= 1.7.0"
    }
  }
}