# Create an ECR repository for Docker images
resource "aws_ecr_repository" "users_service" {
  name = "users-service" # Replace with your desired name
  image_tag_mutability = "MUTABLE" # You can choose "MUTABLE" or "IMMUTABLE" as needed
}

# Create an ECR repository for Helm charts/packages
resource "aws_ecr_repository" "users_service_chart" {
  name = "users_service_chart" # Replace with your desired name
  image_tag_mutability = "IMMUTABLE" # You can choose "MUTABLE" or "IMMUTABLE" as needed
}