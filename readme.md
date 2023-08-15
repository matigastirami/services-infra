# How to Terraform
All the infrastructure provision on this project will be created following terraform official docs

# Commands
* Installing all the providers/plugins: `terraform init` (similar to npm install)
* Formatting files: `terraform fmt`
* Validate configuration: `terraform validate`
* Applying the configuration: `terraform apply`
  * With variables: `terraform apply -var "variable_name=value"`
* Checking state: `terraform state`
* Destroy infrastructure: `terraform destroy`

# Tips and info
* The [terraform.tfstate](terraform.tfstate) file contains the infrastructure history along time
* The [.terraform.lock.hcl](.terraform.lock.hcl) contains all the version references for providers (Similar to package-lock.json)
* 