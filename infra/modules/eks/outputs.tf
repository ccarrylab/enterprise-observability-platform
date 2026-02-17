output "cluster_name" { value = aws_eks_cluster.this.name }
output "cluster_endpoint" { value = aws_eks_cluster.this.endpoint }
output "cluster_id" { value = aws_eks_cluster.this.id }
output "otel_irsa_role_arn" { value = aws_iam_role.otel_irsa.arn }
output "fluentbit_irsa_role_arn" { value = aws_iam_role.fluentbit_irsa.arn }
