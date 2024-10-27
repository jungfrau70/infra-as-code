# AKS에 적합한 Storage Account 생성 CLI

Azure Kubernetes Service(AKS)에 적합한 Storage Account를 생성하기 위해 아래의 Azure CLI 명령어를 사용할 수 있습니다.

```bash
# 변수 설정
RESOURCE_GROUP="wain_common_rg"
STORAGE_ACCOUNT_NAME="wain_common_sa"
LOCATION="koreacentral"

# 리소스 그룹 생성
az group create --name $RESOURCE_GROUP --location $LOCATION

# Storage Account 생성
az storage account create \
    --name $STORAGE_ACCOUNT_NAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --sku Standard_LRS \
    --kind StorageV2
``` ==> 작동하지 않아 portal에서 직접 생성함


위 명령어를 실행하면 지정한 리소스 그룹과 위치에 Standard_LRS SKU를 사용하는 StorageV2 유형의 Storage Account가 생성됩니다.

리소스 그룹이 제대로 생성되었는지 확인하려면 아래의 Azure CLI 명령어를 사용할 수 있습니다.

```bash
# 리소스 그룹 확인
az group show --name $RESOURCE_GROUP
```

위 명령어를 실행하면 지정한 리소스 그룹의 세부 정보를 확인할 수 있습니다.