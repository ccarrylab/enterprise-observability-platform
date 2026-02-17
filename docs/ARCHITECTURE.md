# Architecture

Data paths:
- Logs: Pods -> Fluent Bit DaemonSet -> CloudWatch Logs (optional OpenSearch for centralized search)
- Traces: Apps -> OTLP -> ADOT Collector -> AWS X-Ray
- Metrics: Apps -> OTLP -> ADOT Collector -> CloudWatch Metrics (EMF)
- Alerts: CloudWatch alarms -> SNS

Security model:
- EKS workloads use IRSA (OIDC) for AWS API access (collector writes to X-Ray/CloudWatch; Fluent Bit writes to CloudWatch Logs).
