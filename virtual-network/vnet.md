# Azure Virtual Network Configuration with Terraform

This document describes how to configure an Azure Virtual Network (VNet) using Terraform, and how to retrieve variable values from Azure Key Vault.

## Prerequisites

- Azure CLI installed
- Terraform installed
- Access to an Azure subscription
- An existing Azure Key Vault with the necessary secrets

## Steps

### 1. Initialize Terraform

```bash
terraform init
```


### 1.1 Configure Backend

Before initializing Terraform, you need to configure the backend to store the state file. Create a `backend.tf` file with the following content:

```hcl
terraform {
    backend "azurerm" {
        resource_group_name  = "your-resource-group"
        storage_account_name = "yourstorageaccount"
        container_name       = "tfstate"
        key                  = "terraform.tfstate"
    }
}
```

Replace `"your-resource-group"`, `"yourstorageaccount"`, and `"tfstate"` with your actual resource group name, storage account name, and container name respectively.

After creating the `backend.tf` file, run the `terraform init` command again to initialize the backend.


### 1.2 Verify Values with Azure CLI

Before proceeding, you may want to verify the values stored in Azure Key Vault using the Azure CLI. This can help ensure that the secrets are correctly set up.

To list all secrets in your Key Vault, use the following command:

```bash
keyvault_name="WainDevOps"
az keyvault secret list --vault-name $keyvault_name
```

To retrieve a specific secret, use:

```bash
keyvault_name="WainDevOps"
TF_VAR_AGENT_SUBNET_NAME="TF-VAR-AGENT-SUBNET-NAME"
az keyvault secret show --name $TF_VAR_AGENT_SUBNET_NAME --vault-name $keyvault_name
```

Replace `your-keyvault-name` and `vnet-name-secret` with your actual Key Vault name and secret name respectively.


### 2. Define Variables in `variables.tf`

Ensure that your `variables.tf` file contains the necessary variable definitions. For example:

```hcl
variable "vnet_name" {
    description = "The name of the Virtual Network"
    type        = string
}

variable "vnet_address_space" {
    description = "The address space for the Virtual Network"
    type        = list(string)
}
```

### 3. Retrieve Secrets from Azure Key Vault

In your Terraform configuration, use the `azurerm_key_vault_secret` data source to retrieve secrets from Azure Key Vault. For example:

```hcl
provider "azurerm" {
    features {}
}

data "azurerm_key_vault" "example" {
    name                = "your-keyvault-name"
    resource_group_name = "your-resource-group"
}

data "azurerm_key_vault_secret" "vnet_name" {
    name         = "vnet-name-secret"
    key_vault_id = data.azurerm_key_vault.example.id
}

data "azurerm_key_vault_secret" "vnet_address_space" {
    name         = "vnet-address-space-secret"
    key_vault_id = data.azurerm_key_vault.example.id
}

variable "vnet_name" {
    description = "The name of the Virtual Network"
    type        = string
    default     = data.azurerm_key_vault_secret.vnet_name.value
}

variable "vnet_address_space" {
    description = "The address space for the Virtual Network"
    type        = list(string)
    default     = [data.azurerm_key_vault_secret.vnet_address_space.value]
}
```

### 4. Create the Virtual Network

In your main Terraform configuration file (e.g., `main.tf`), use the variables to create the VNet:

```hcl
resource "azurerm_virtual_network" "example" {
    name                = var.vnet_name
    address_space       = var.vnet_address_space
    location            = "East US"
    resource_group_name = "your-resource-group"
}
```

### 5. Apply the Configuration

```bash
terraform apply
```

This will create the Azure Virtual Network using the values stored in Azure Key Vault.

## Conclusion

By following these steps, you can securely manage your Terraform variables using Azure Key Vault, ensuring that sensitive information is not hard-coded in your Terraform files.

