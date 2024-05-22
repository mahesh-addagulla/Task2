terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "COMMON-RG"
    storage_account_name = "azb42devtfstate"
    container_name       = "tfstate"
    key                  = "azb42workspaces.tfstate"
  }

}

#Default Provider Dev Subscription
provider "azurerm" {
  subscription_id = var.deploy_sub_id
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}


provider "azurerm" {
  subscription_id = var.prod_sub_id
  alias           = "Prod"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

