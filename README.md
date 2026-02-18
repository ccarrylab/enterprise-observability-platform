# Enterprise Observability Platform on AWS

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

![IMG_1300](https://github.com/user-attachments/assets/2c8e1baa-9dc2-4ac2-aa76-22d668ecf521)


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
Cleanup: cd infra && terraform destroy

Structure
text
.
├── infra/              # Terraform modules (VPC/EKS/IRSA/OpenSearch)
│   ├── modules/        # Reusable (network/eks/opensearch)
│   └── environments/   # dev/staging/prod state isolation
├── k8s/                # Templated manifests (rendered via outputs)
├── apps/api/           # OTLP-instrumented Node.js workload
├── scripts/            # bootstrap.sh automation
└── docs/               # Architecture/runbooks/JD-mapping
Skills Demonstrated
AWS Certified DevOps Pro Level:

EKS 1.29: Managed groups + IRSA for pod auth

Observability: ADOT Collector -> X-Ray/CloudWatch/OpenSearch

Security: Multi-AZ VPC, private subnets, least-privilege IAM

IaC: Modular Terraform + remote S3/DynamoDB backend

GitOps: ArgoCD-ready manifests

Cost Breakdown (us-east-1, dev usage)
Resource	Spec	Monthly Cost	Notes
EKS Control Plane	Standard	$73	Always-on
EC2 Nodes	2x t3.medium	$54	Spot-eligible
OpenSearch	2x t3.medium.search	$165	Logs/traces
CloudWatch/X-Ray	Logs+metrics	$25	Sampling optimized
Total		~$317/mo	Destroy idle clusters
Pro tip: Use Karpenter + Spot for 60% savings.

Production Features
IRSA: Scoped IAM for FluentBit/ADOT

Multi-AZ: HA across 3 AZs

CI/CD Ready: GitHub Actions validation

Cost-Alerts: OpenCost + CloudWatch budgets

Resources
Architecture

Runbooks

JD Mapping

Portfolio
SuperBowlEdge-Chaos

More @ccarrylab

MIT License
Suggestions via Issues welcome.

Built by Cohen H. Carryl | Sr Cloud Engineer | 3x AWS | Chaos Engineering Creator
