#!/bin/bash

cat > README.md << 'EOF'
# Enterprise Observability Platform on AWS *** (Work in Progress) ***

[![Terraform](https://img.shields.io/badge/Terraform-1.6+-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EKS%20OpenSearch%20X--Ray-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> Production Portfolio: Maps enterprise tools (Splunk/AppDynamics/Zenoss) to AWS-native observability using OpenTelemetry, EKS, and IRSA.

## Enterprise Mapping

| Enterprise Tool | AWS-Native Equivalent | Implementation |
|-----------------|----------------------|---------------|
| Splunk | OpenSearch + Fluent Bit | Logs aggregation/search |
| AppDynamics | ADOT + X-Ray | Distributed tracing |
| Prometheus/Zabbix | CloudWatch + OTLP | Metrics + EMF |
| PagerDuty | CloudWatch Alarms + SNS | Alerting workflows |

## Architecture

<img width="1799" height="2207" alt="IMG_1315" src="https://github.com/user-attachments/assets/33e74430-c2f0-4d3f-80e2-9f6e7c9351cb" />

## Quick Start (5min)

### Prerequisites
- AWS account (admin IAM)
- Terraform >=1.6, AWS CLI, kubectl, Docker
- brew install gettext (for envsubst)

```bash
git clone https://github.com/ccarrylab/enterprise-observability-platform.git
cd enterprise-observability-platform

./scripts/bootstrap.sh  # Backend + EKS + apps

kubectl get pods -n observability
kubectl port-forward svc/observability-api 8080:80
curl http://localhost:8080/work  # Generates traces/logs/metrics