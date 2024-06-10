terraform {
  required_version = ">=1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.79.0"
    }
  }
  backend "local" {}
}
provider "azurerm" {
  subscription_id = var.subscription_id
  features {
  }
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = module.naming.resource_group.name
}
