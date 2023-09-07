#module "eks_cluster" {
#  source = "./modules/eks" # Adjust the path to your EKS module
#}

module "mongodb_atlas" {
  source = "./modules/mongodb_atlas" # Adjust the path to your MongoDB Atlas module
}