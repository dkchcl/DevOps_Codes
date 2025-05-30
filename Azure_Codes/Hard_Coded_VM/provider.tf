terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.28.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "d4681c5e-21a1-405d-a6b7-3c3a7b517e85"
}