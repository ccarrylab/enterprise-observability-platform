output "cluster_name" {
  value       = module.eks.cluster_name
  description = "EKS cluster name"
}

output "cluster_region" {
  value       = var.aws_region
  description = "AWS region"
}

output "api_ecr_repo_url" {
  value       = module.ecr.repository_url
  description = "ECR repository URL for API"
}

output "opensearch_endpoint" {
  value       = module.opensearch.endpoint
  description = "OpenSearch domain endpoint"
}

output "vpc_id" {
  value       = module.network.vpc_id
  description = "VPC ID"
}
