# Runbooks

## Collector health
- kubectl -n observability get deploy,po
- kubectl -n observability logs deploy/otel-collector

## Log pipeline
- kubectl -n observability logs ds/fluent-bit

## X-Ray validation
- Generate requests against the demo API service and confirm X-Ray service map updates in AWS console.

## Alarm response (examples)
- OpenSearch: investigate domain status (red/yellow), JVM pressure, storage space.
- EKS control plane logs: inspect CloudWatch log group for API/audit/authenticator errors.
