# Services Infrastructure
This repository contains all the necessary TF code to deploy a complete infrastructure to AWS, including an EKS cluster, 
a VPC and its security groups, apart from a mongodb atlas M0 cluster (free tier).

# Software needed
* [Terraform](http://replace-this-link.com)
* [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

## Useful commands TF
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

## Files explanation
* The [terraform.tfstate](terraform.tfstate) file contains the infrastructure history along time (sensitive information)
* The [.terraform.lock.hcl](.terraform.lock.hcl) contains all the version references for providers (Similar to package-lock.json)
* The [terraform.tfvars](terraform.tfvars) file contains all the variables like a `.env`

## TO-DO
* Find a place to store the `tfstate` file (S3?)
* Find a way to store sensitive values as credentials and keys (Secrets manager?)
* Provision EKS cluster and security group
* Provision S3 bucket for users-service

# Terragrunt
* Use `terragrunt init` to initialize configurations
* Use `terragrunt apply` to create the infrastructure in your cloud
* Use `terragrunt run-all destroy` to destroy multiple configurations (i.e. all the environments at the same time [does run-all works for apply?])
* 