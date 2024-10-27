terraform {
    backend "azurerm" {
        resource_group_name  = "wainaks_group"
        storage_account_name = "wain7common7sa"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}


```bash
# Retrieve the resource group name
resource_group_name=$(az group list --query "[0].name" -o tsv)

# Retrieve the storage account name
storage_account_name=$(az storage account list --resource-group $resource_group_name --query "[0].name" -o tsv)

# Output the values
echo "Resource Group Name: $resource_group_name"
echo "Storage Account Name: $storage_account_name"
```

```bash
# Create a container in the storage account
container_name="tfstate"
az storage container create --name $container_name --account-name $storage_account_name

# Output the container name
echo "Container Name: $container_name"
```