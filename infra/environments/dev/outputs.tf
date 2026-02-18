output "cluster_name" {
  value = module.observability.cluster_name
}

output "cluster_endpoint" {
  value     = module.observability.cluster_endpoint
  sensitive = true
}

output "api_ecr_repo_url" {
  value = module.observability.api_ecr_repo_url
}

output "otel_irsa_role_arn" {
  value = module.observability.otel_irsa_role_arn
}

output "fluentbit_irsa_role_arn" {
  value = module.observability.fluentbit_irsa_role_arn
}

output "node_group_name" {
  value = module.observability.node_group_name
}

output "opensearch_endpoint" {
  value = module.observability.opensearch_endpoint
}
