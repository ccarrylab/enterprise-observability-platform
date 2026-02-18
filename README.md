# Enterprise Observability Platform on AWS

[![Terraform](https://img.shields.io/badge/Terraform-1.6+-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EKS%20OpenSearch%20X--Ray-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Status](https://img.shields.io/badge/Status-Production%20Ready-success)](https://github.com/ccarrylab/enterprise-observability-platform)

&gt; **Production Portfolio**: Enterprise-grade observability platform demonstrating migration patterns from commercial tools (Splunk/AppDynamics/Zenoss) to AWS-native services using OpenTelemetry, EKS, and IRSA.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Enterprise Tool Mapping](#enterprise-tool-mapping)
- [Quick Start](#quick-start)
- [Project Structure](#project-structure)
- [Skills Demonstrated](#skills-demonstrated)
- [Cost Optimization](#cost-optimization)
- [Production Features](#production-features)
- [Resources](#resources)
- [Author](#author)

---

## Overview

This platform provides a comprehensive, production-ready observability stack on AWS, designed to replace expensive enterprise monitoring solutions with scalable, cloud-native alternatives. Built with Infrastructure as Code principles and GitOps workflows.

### Key Capabilities

- **Unified Telemetry**: Collect traces, metrics, and logs via OpenTelemetry
- **Auto-Scaling Infrastructure**: Karpenter-powered node provisioning
- **Security-First**: IRSA (IAM Roles for Service Accounts) for pod-level permissions
- **Cost Visibility**: Real-time Kubernetes cost allocation with OpenCost

---

## Architecture


<img width="1799" height="2207" alt="IMG_1315" src="https://github.com/user-attachments/assets/06724f15-e635-4c54-9ca0-d83e65691a81" />

### Data Flow Architecture

The platform implements a complete 6-stage observability pipeline:


### Layer 1: State Management (Foundation)

| Component | Technology | Configuration |
|-----------|-----------|---------------|
| **Terraform State** | Amazon S3 | SSE-S3 Encrypted, Versioning Enabled |
| **State Locking** | DynamoDB | Pay-per-request, Point-in-time recovery |

### Layer 2: Amazon EKS Cluster (Compute)

**Kubernetes v1.28+** | **Multi-AZ** | **IRSA Enabled**

| Capability | Implementation | Benefit |
|-----------|---------------|---------|
| GitOps | ArgoCD v2.9+ (App of Apps pattern) | Declarative app deployments from Git |
| Auto-scaling | Karpenter v0.34+ (Spot ready) | Right-sized nodes in seconds vs minutes |
| Service Mesh | Cilium v1.14+ (Hubble UI) | High-performance L3-L7 networking |
| Cost Management | OpenCost v1.108+ (Allocation API) | Real-time cost allocation by namespace |

### Layer 3: Application Workloads (Instrumentation)

OpenTelemetry-instrumented services with sidecar collection:

| Service | Technology | Role |
|---------|-----------|------|
| **Demo API Service** | Node.js + Express + OTel Auto-instrumentation | Generates traces, metrics, logs |
| **ADOT Collector** | AWS Distro for OpenTelemetry (DaemonSet, Sidecar injection ready) | Receives OTLP, exports to AWS |
| **Fluent Bit** | High-Performance Log Router (DaemonSet, Parser filters, S3 backup) | Collects container logs from node |

### Layer 4: Observability Stack (The Three Pillars)

| Pillar | AWS Service | Configuration |
|--------|------------|---------------|
| **Distributed Tracing** | AWS X-Ray | Service Maps, Trace Analytics, 5% Sampling |
| **Metrics & Logs** | CloudWatch | EMF, Container Insights, 30-day retention |
| **Log Analytics & Search** | OpenSearch | 2× t3.medium, AES-256, ISM policies |

**Data Flows:**
- End-to-end request flow visualization → X-Ray
- Infrastructure and application metrics → CloudWatch
- Centralized log aggregation & search → OpenSearch

### Layer 5: Alerting & Remediation (Automated Response)

| Component | Integration | Capability |
|-----------|------------|------------|
| **Amazon SNS** | Email subscriptions, Slack integration, PagerDuty routing | Multi-Channel Alerting |
| **EventBridge** | Lambda targets, Step Functions, SSM Run Command | Auto-Remediation Engine |

**Self-healing actions:** Restart pods, scale resources automatically

---

## Enterprise Tool Mapping

| Enterprise Tool | AWS-Native Equivalent | Implementation Pattern |
|-----------------|----------------------|------------------------|
| **Splunk** | OpenSearch + Fluent Bit | Centralized log aggregation and search |
| **AppDynamics** | ADOT + X-Ray | Distributed tracing and service mapping |
| **Prometheus/Zabbix** | CloudWatch + OTLP | Metrics collection with EMF support |
| **PagerDuty** | CloudWatch Alarms + SNS | Multi-channel alerting workflows |

---

## Quick Start

### Prerequisites

- AWS account with admin IAM privileges
- Terraform >= 1.6
- AWS CLI v2
- kubectl
- Docker
- gettext (`brew install gettext` for envsubst)

### Deployment

```bash
# Clone repository
git clone https://github.com/ccarrylab/enterprise-observability-platform.git
cd enterprise-observability-platform

# Initialize and deploy entire stack (5 minutes)
./scripts/bootstrap.sh

# Verify deployment
kubectl get pods -n observability

# Access API and generate telemetry
kubectl port-forward svc/observability-api 8080:80
curl http://localhost:8080/work


### Cleanup

```bash

cd infra && terraform destroy

### Project Structure

enterprise-observability-platform/
├── infra/                    # Terraform modules
│   ├── modules/
│   │   ├── eks/             # EKS cluster with IRSA
│   │   ├── networking/      # VPC, subnets, security groups
│   │   ├── observability/   # X-Ray, CloudWatch, OpenSearch
│   │   └── addons/          # Karpenter, Cilium, ArgoCD
│   └── backend/             # S3 + DynamoDB state management
├── apps/                     # Application manifests
│   ├── demo-api/            # Sample instrumented service
│   └── collectors/          # ADOT and Fluent Bit configs
├── scripts/                  # Automation scripts
│   └── bootstrap.sh         # One-command deployment
└── docs/                     # Documentation
    ├── images/              # Architecture diagrams
    ├── runbooks/            # Operational procedures
    └── architecture/        # Design decisions

### Skills Demonstrated

### AWS Certified DevOps Professional Level

EKS 1.29: Managed node groups with IRSA for secure pod authentication
Observability: ADOT Collector integration with X-Ray, CloudWatch, and OpenSearch
Security: Multi-AZ VPC architecture, private subnets, least-privilege IAM policies
IaC: Modular Terraform with remote S3/DynamoDB backend for state management
GitOps: ArgoCD-ready Kubernetes manifests for continuous deployment

### Cost Optimization

### Breakdown (us-east-1, development usage)

| Component                 | Monthly Cost | Optimization                       |
| ------------------------- | ------------ | ---------------------------------- |
| EKS Control Plane         | \$72         | Fixed                              |
| OpenSearch (2x t3.medium) | ~\$60        | ISM policies for retention         |
| CloudWatch Logs           | ~\$20        | Log filtering, 30-day retention    |
| Compute (t3.medium)       | ~\$30        | **Karpenter + Spot = 60% savings** |


### Production Features

✅ IRSA: Scoped IAM roles for Fluent Bit and ADOT (no long-term credentials)
✅ High Availability: Multi-AZ deployment across 3 availability zones
✅ CI/CD Ready: GitHub Actions workflows for Terraform validation
✅ Cost Governance: OpenCost integration with CloudWatch budget alerts
✅ Auto-Remediation: EventBridge rules for self-healing (pod restart, scaling)
Resources

Architecture Deep Dive
Operational Runbooks
Job Description Mapping
Related Projects

SuperBowlEdge-Chaos - Chaos engineering platform
Author

Cohen H. Carryl
Senior Cloud Engineer | 3x AWS Certified | Chaos Engineering Creator
https://github.com/ccarrylab
https://linkedin.com/in/yourprofile
License

MIT License - see LICENSE for details.
Contributions and suggestions via Issues are welcome!
