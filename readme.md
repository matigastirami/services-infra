# Services Infrastructure
This repository contains all the necessary TF code to deploy a complete infrastructure to AWS, including an EKS cluster, 
a VPC and its security groups, apart from a mongodb atlas M0 cluster (free tier).

# Software needed
* [Terraform](http://replace-this-link.com)
* [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/)

# How to provide infrastructure
1. Make sure you have TF and Terragrunt installed
2. cd into some environment folder (example `cd environment/dev`)
3. Run `terragrunt run-all init` to start repositories (TODO: manage remote state in a S3 bucket)
4. Run `terragrunt run-all apply` to create the infrastructure

# How to destroy the infrastructure
1. cd into some environment folder (example `cd environment/dev`)
2. Run `terragrunt run-all destroy`

# About terragrunt
* Terragrunt `run-all` make sure the dependency tree is created in order, so there is no need to go module by module executing the apply command
* When running plan, some modules requires for example a real EKS instance (Helm module). We can by-pass that by using `--terragrunt-excluder-dir kubernetes-addons`

# Connecting to the cluster 

## kubectl
1. `aws eks update-kubeconfig --name ${env_name} --region ${region}` (aws-cli needed)
2. `kubectl get nodes`

## Managing state
* State is saved to a S3 bucket that must be manually created
* Also need a DynamoDB table to avoid having problems when many team members try to run the infra changes at once

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