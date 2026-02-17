output "cluster_name" { value = module.eks.cluster_name }
output "cluster_region" { value = var.aws_region }

output "otel_irsa_role_arn" { value = module.eks.otel_irsa_role_arn }
output "fluentbit_irsa_role_arn" { value = module.eks.fluentbit_irsa_role_arn }

output "api_ecr_repo_url" { value = module.ecr.api_repo_url }

output "opensearch_endpoint" { value = module.opensearch.endpoint }
output "sns_topic_arn" { value = module.alerts.sns_topic_arn }
