# Job Description Mapping

Administration / implementation:
- Terraform modules provision and configure: VPC, EKS, ECR, OpenSearch, CloudWatch alarms + SNS.

Monitoring / maintenance:
- Fluent Bit ships logs.
- ADOT Collector ships traces and metrics.

Dashboards / alerts:
- CloudWatch alarms module and SNS topic.
- X-Ray service map and CloudWatch metrics provide operational views.

OpenTelemetry:
- OTLP receivers, batching, memory limiter, X-Ray exporter, EMF metrics exporter.

Kubernetes observability:
- EKS managed node group, DaemonSet log agent, in-cluster OTel collector.
