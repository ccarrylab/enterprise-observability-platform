# Enterprise Observability Platform on AWS

[![Terraform](https://img.shields.io/badge/Terraform-1.6+-623CE4?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EKS%20%7C%20OpenSearch%20%7C%20X--Ray-FF9900?logo=amazon-aws)](https://aws.amazon.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> **Portfolio Project**: Production-grade observability stack mapping enterprise tools (Splunk/AppDynamics/Zenoss) to AWS-native services

## 🎯 What This Demonstrates

**Enterprise Observability Mapped to AWS:**
- **Logs** (Splunk → AWS): Fluent Bit → CloudWatch Logs + OpenSearch
- **Traces** (AppDynamics → AWS): OpenTelemetry → ADOT Collector → X-Ray
- **Metrics** (Prometheus → AWS): OTLP → CloudWatch Metrics (EMF)
- **Alerting** (PagerDuty → AWS): CloudWatch Alarms → SNS
- **Infrastructure**: EKS with IRSA, multi-AZ, VPC best practices

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                         AWS Cloud                            │
│  ┌──────────────────────────────────────────────────────┐  │
│  │  Amazon EKS Cluster (Multi-AZ)                       │  │
│  │  ┌──────────────┐  ┌──────────────┐  ┌────────────┐ │  │
│  │  │ Demo API     │  │ ADOT         │  │ Fluent Bit │ │  │
│  │  │ (OTLP inst.) │→ │ Collector    │→ │            │ │  │
│  │  └──────────────┘  └──────┬───────┘  └─────┬──────┘ │  │
│  └──────────────────────────┼────────────────┼────────┘  │
│                              │                │            │
│         ┌────────────────────┼────────────────┼─────────┐ │
│         │                    ↓                ↓         │ │
│         │  CloudWatch     X-Ray       OpenSearch       │ │
│         │  Logs/Metrics   Traces      (Logs Search)    │ │
│         └────────┬──────────────────────────────────────┘ │
│                  │                                         │
│                  ↓                                         │
│         ┌────────────────┐                                │
│         │  SNS Alerts    │                                │
│         └────────────────┘                                │
└─────────────────────────────────────────────────────────────┘
```

## 🚀 Quick Start

### Prerequisites
- AWS Account with admin access
- Terraform 1.6+
- AWS CLI configured
- kubectl
- Docker
- envsubst (install: `brew install gettext` on macOS)

### Deploy

```bash
# 1. Clone and navigate
git clone https://github.com/ccarrylab/enterprise-observability-platform.git
cd enterprise-observability-platform

# 2. Deploy infrastructure + application
./scripts/bootstrap.sh

# 3. Test the observability stack
kubectl get pods -n observability
kubectl -n default port-forward svc/observability-api 8080:80
curl http://localhost:8080/work  # Generates traces/logs/metrics
```

### Cleanup

```bash
cd infra
terraform destroy
```

## 📁 Project Structure

```
.
├── infra/              # Terraform IaC
│   ├── modules/
│   │   ├── network/    # VPC, subnets, NAT
│   │   ├── eks/        # EKS cluster, node group, IRSA
│   │   ├── opensearch/ # OpenSearch domain for log search
│   │   ├── ecr/        # Container registry
│   │   └── alerts/     # SNS topic for notifications
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── backend.tf      # Remote state config (optional)
├── k8s/
│   ├── templates/      # Templated Kubernetes manifests
│   └── rendered/       # Output (rendered with terraform outputs)
├── apps/api/           # Demo Node.js API with OTLP instrumentation
├── scripts/            # Automation (bootstrap, render)
└── docs/               # Architecture, runbooks, JD mapping
```

## 🎓 Skills Demonstrated

**DevOps/SRE:**
- Infrastructure as Code (Terraform modules, remote state)
- Container orchestration (EKS, Kubernetes RBAC, IRSA)
- Observability instrumentation (OpenTelemetry, Fluent Bit, ADOT)
- CI/CD (GitHub Actions for Terraform validation)

**AWS Services:**
- Compute: EKS, ECR
- Networking: VPC, NAT Gateway, Security Groups
- Observability: CloudWatch, X-Ray, OpenSearch
- IAM: IRSA (IAM Roles for Service Accounts)

**Cloud Architecture:**
- Multi-AZ high availability
- Least privilege IAM
- Cost optimization (t3.medium nodes)
- Security best practices (private subnets, VPC endpoints ready)

## 📊 Cost Estimate

Monthly AWS costs (us-east-1, development usage):
- EKS Control Plane: $73
- EC2 (2x t3.medium): ~$60
- OpenSearch (2x t3.medium.search): ~$140
- Data Transfer/CloudWatch: ~$30
- **Total: ~$300/month**

*Destroy when not in use to avoid charges*

## 🎖️ Certifications Applied

This project demonstrates skills from:
- AWS Certified DevOps Engineer – Professional
- Certified Kubernetes Administrator (CKA)
- Google Cloud Professional Cloud Architect

## 📚 Documentation

- [Architecture Deep Dive](docs/ARCHITECTURE.md)
- [Operational Runbooks](docs/RUNBOOKS.md)
- [Job Description Mapping](docs/JD-MAPPING.md)

## 🔧 Advanced Features

### Remote State Backend

See [infra/backend.tf](infra/backend.tf) for instructions on setting up S3 + DynamoDB backend for team collaboration.

### CI/CD Pipeline

GitHub Actions workflow validates Terraform on every push:
- Format check
- Validation
- Ready for plan/apply automation

## 🔗 Related Projects

- [SuperBowl Edge Chaos Platform](https://github.com/ccarrylab/chaos-edge-devops)
- More DevOps projects: [github.com/ccarrylab](https://github.com/ccarrylab)

## 🤝 Contributing

This is a portfolio project, but suggestions are welcome via issues.

## 📄 License

MIT License - see [LICENSE](LICENSE) for details

---

**Portfolio Note**: This project demonstrates production-grade DevOps practices I've implemented across multiple startups as their first DevOps hire. It showcases the ability to translate enterprise monitoring requirements into cost-effective cloud-native solutions.

**Key Highlights:**
- ✅ Production-ready Terraform modules
- ✅ OpenTelemetry instrumentation
- ✅ Multi-AZ high availability
- ✅ IRSA for secure pod authentication
- ✅ Comprehensive documentation
- ✅ Automated deployment scripts
