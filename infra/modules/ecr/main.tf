resource "aws_ecr_repository" "api" {
  name         = "${var.name}-api"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  image_tag_mutability = "MUTABLE"

  tags = var.tags
}

output "repository_url" {
  value       = aws_ecr_repository.api.repository_url
  description = "ECR repository URL"
}

output "repository_name" {
  value       = aws_ecr_repository.api.name
  description = "ECR repository name"
}
