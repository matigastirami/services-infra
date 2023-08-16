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
* Use `-json` flag to format the outputs: `terraform output -json`

# Files explanation
* The [terraform.tfstate](terraform.tfstate) file contains the infrastructure history along time (sensitive information)
* The [.terraform.lock.hcl](.terraform.lock.hcl) contains all the version references for providers (Similar to package-lock.json)
* The [terraform.tfvars](terraform.tfvars) file contains all the variables like a `.env`

# Tips
* When Terraform runs, it looks in your environment for variables that match the pattern TF_VAR_<VARIABLE_NAME>, and assigns those values to the corresponding Terraform variables in your configuration.
>This can be useful in CI/CD environments
* 