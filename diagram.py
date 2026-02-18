#!/usr/bin/env python3
"""
Enterprise Observability Platform - Updated Architecture Diagram
Run: pip install diagrams && python diagram_generator.py
"""

from diagrams import Diagram, Cluster, Edge
from diagrams.aws.compute import EKS, EC2
from diagrams.aws.database import Dynamodb
from diagrams.aws.storage import S3
from diagrams.aws.integration import SNS, Eventbridge
from diagrams.aws.management import Cloudwatch
from diagrams.aws.management import CloudwatchLogs
from diagrams.aws.devtools import XRay
from diagrams.k8s.compute import Pod, DaemonSet
from diagrams.onprem.gitops import ArgoCD
from diagrams.onprem.monitoring import Grafana
from diagrams.generic.network import Firewall

# Create the diagram
with Diagram(
    "Enterprise Observability Platform - Updated",
    show=True,
    direction="TB",
    graph_attr={
        "bgcolor": "#232f3e",
        "fontcolor": "white",
        "fontsize": "20",
        "splines": "ortho"
    }
):
    # AWS Cloud Boundary
    with Cluster("AWS Cloud"):
        
        # State Management (bottom layer)
        with Cluster("State Management"):
            s3 = S3("S3\nTerraform State")
            dynamodb = Dynamodb("DynamoDB\nState Locking")
        
        # EKS Cluster
        with Cluster("Amazon EKS Cluster (Multi-AZ)"):
            
            # Platform Layer (NEW COMPONENTS)
            with Cluster("Platform Layer (NEW)"):
                argocd = ArgoCD("ArgoCD\nGitOps")
                karpenter = EC2("Karpenter\nAuto-scaling")
                cilium = Firewall("Cilium eBPF\nService Mesh")
                opencost = Grafana("OpenCost\nFinOps")
            
            # Application Workloads
            with Cluster("Application Workloads"):
                api = Pod("Demo API\nOTLP Instrumented")
                adot = DaemonSet("ADOT Collector")
                fluent = DaemonSet("Fluent Bit")
        
        # Observability Stack
        with Cluster("Observability Stack"):
            cloudwatch = Cloudwatch("CloudWatch")
            xray = XRay("X-Ray")
            opensearch = CloudwatchLogs("OpenSearch")
        
        # Alerting
        with Cluster("Alerting & Remediation"):
            sns = SNS("SNS Alerts")
            eventbridge = Eventbridge("EventBridge\nAuto-remediation")
    
    # Data flows
    api >> adot
    api >> fluent
    adot >> xray
    adot >> cloudwatch
    fluent >> opensearch
    fluent >> cloudwatch
    
    # Platform management (dotted)
    argocd - Edge(style="dotted") >> api
    karpenter - Edge(style="dotted") >> api
    cilium - Edge(style="dotted") >> api
    opencost - Edge(style="dotted") >> api
    
    # Alerting flow
    cloudwatch >> sns
    xray >> sns
    opensearch >> sns
    sns >> eventbridge
    eventbridge - Edge(style="dashed") >> api

print("✅ Diagram generated: enterprise_observability_platform.png")