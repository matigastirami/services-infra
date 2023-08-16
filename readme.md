# How to Terraform
All the infrastructure provision on this project will be created following terraform official docs

# Commands
* Installing all the providers/plugins: `terraform init` (similar to npm install)
* Formatting files: `terraform fmt`
* Validate configuration: `terraform validate`
* Applying the configuration: `terraform apply`
  * With variables: `terraform apply -var "variable_name=value"`
  * Passing variables file `terraform apply -var-file=/path/to/file`
* Checking state: `terraform state`
* Destroy infrastructure: `terraform destroy`
* Check what is going to be changed beforehand: `terraform plan`

# Files explanation
* The [terraform.tfstate](terraform.tfstate) file contains the infrastructure history along time (sensitive information)
* The [.terraform.lock.hcl](.terraform.lock.hcl) contains all the version references for providers (Similar to package-lock.json)
* The [terraform.tfvars](terraform.tfvars) file contains all the variables like a `.env`