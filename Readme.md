# USE MODULE TO DEPLOY VM IN DEV AND QA ENVIRONMENT
## ARCHITECTURE OF MODULE

#### modules directory: This is the place where we create scaleton of the resources.


## Deploy VM1 
``` 
# cd vm1
# terraform init -backend-config="storage_account_name= var.storage_account_name" -backend-config="container_name=var.container_name" -backend-config="access_key=var.access_key" -backend-config="key=vm1-terraform.tfstate"
# terraform plan -var-file=vm1.tfvars
# terraform apply -var-file-vm1.tfvars
```
## Deploy VM2
``` 
# cd vm2
# terraform init -backend-config="storage_account_name= var.storage_account_name" -backend-config="container_name=var.container_name" -backend-config="access_key=var.access_key" -backend-config="key=vm2-terraform.tfstate"
# terraform plan -var-file=vm2.tfvars
# terraform apply -var-file-vm2.tfvars
```
