

provider "azurerm" {
  features {}
  subscription_id = "5fc983dd-0425-421b-af56-35481b3c92d4"
  }

module "cluster"{
  source = "./Modules"
  component = "cluster1"
  subscription_id = "5fc983dd-0425-421b-af56-35481b3c92d4"
}


terraform {
  backend "azurerm" {
    resource_group_name  = "project-Alpha"
    storage_account_name = "projectalpha13"
    container_name       = "kubernates"
    key                  = "terraform.tfstate"

  }
}
 


