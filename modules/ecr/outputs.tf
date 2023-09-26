output "ecr_users_service_url" {
  value = aws_ecr_repository.users_service.repository_url
}

output "ecr_users_service_chart_url" {
  value = aws_ecr_repository.users_service_chart.repository_url
}