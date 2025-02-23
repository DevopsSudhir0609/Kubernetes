

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}



module "clustervm" {
  source = "./Kubernetes/Modules"
  component = var.component

}



terraform {
  backend "azurerm" {
    resource_group_name  = "project-Alpha"
    storage_account_name = "projectalpha13"
    container_name       = "kubernates"
    key                  = "terraform.tfstate"

  }
}
 


