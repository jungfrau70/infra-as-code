# 변수 설정
RESOURCE_GROUP="wain_common_rg"
STORAGE_ACCOUNT_NAME="wain_common_sa"
LOCATION="koreacentral"

# 리소스 그룹 생성
# az group create --name $RESOURCE_GROUP --location $LOCATION

# Storage Account 생성
az storage account create \
    --name $STORAGE_ACCOUNT_NAME \
    --resource-group $RESOURCE_GROUP \
    --location $LOCATION \
    --sku Standard_LRS \
    --kind StorageV2


    # Azure CLI 로그인
    az login

    # 구독 설정
    SUBSCRIPTION_ID="b6f97aed-4542-491f-a94c-e0f05563485c"
    az account set --subscription $SUBSCRIPTION_ID


==> 작동하지 않아 portal에서 직접 생성함
    