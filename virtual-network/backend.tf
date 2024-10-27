terraform {
    backend "azurerm" {
        resource_group_name  = "wainaks_group"
        storage_account_name = "wain7common7sa"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}


