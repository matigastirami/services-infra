terraform {
  source = "../../../modules/eks"
}

include "root" {
  path = find_in_parent_folders()
}

include "env" {
  path = find_in_parent_folders("env.hcl")
  expose = true
  merge_strategy = "no_merge"
}

inputs = {
  eks_version = "1.26"
  env = include.env.locals.env
  eks_name = "demo"
  subnets_ids = dependency.vpc.outputs.private_subnet_ids

  node_groups = {
    general = {
      capacity_type = "ON_DEMAND"
      instance_type = ["t1.micro"] # t3a.xlarge for emptying your wallet
      scaling_config = {
        desired_size = 1
        max_size = 1
        min_size = 0
      }
    }
  }
}

# This is when terragrunt shines as it's more difficult doing this with plain terraform
dependency "vpc" {
  config_path = "../vpc"

  # This is useful for running terraform plan simultaneously in both modules
  mock_outputs = {
    private_subnet_ids = ["subnet-1234", "subnet-5678"]
  }
}