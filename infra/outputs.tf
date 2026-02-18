output "cluster_region" {
  description = "AWS region"
  value       = data.aws_region.current.name
}

output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS endpoint"
  value       = module.eks.cluster_endpoint
  sensitive   = true
}

output "api_ecr_repo_url" {
  description = "ECR repository URL"
  value       = module.ecr.repository_url
}

output "otel_irsa_role_arn" {
  description = "OTel IRSA role ARN"
  value       = module.eks.otel_irsa_role_arn
}

output "fluentbit_irsa_role_arn" {
  description = "FluentBit IRSA role ARN"
  value       = module.eks.fluentbit_irsa_role_arn
}

output "node_group_name" {
  description = "EKS node group name"
  value       = module.eks.node_group_name
}

output "opensearch_endpoint" {
  description = "OpenSearch endpoint"
  value       = module.opensearch.endpoint
}
