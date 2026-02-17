#!/usr/bin/env bash
set -euo pipefail

# Always run relative to repo root (where this script lives)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$REPO_ROOT"

command -v terraform >/dev/null
command -v aws >/dev/null
command -v kubectl >/dev/null
command -v docker >/dev/null
command -v envsubst >/dev/null || { echo "envsubst is required (install gettext)"; exit 1; }

echo "1) Terraform apply"
terraform -chdir=infra init
terraform -chdir=infra apply -auto-approve

AWS_REGION="$(terraform -chdir=infra output -raw cluster_region)"
CLUSTER_NAME="$(terraform -chdir=infra output -raw cluster_name)"
API_REPO_URL="$(terraform -chdir=infra output -raw api_ecr_repo_url)"

echo "2) Wait for EKS control plane + node group"
aws eks wait cluster-active --region "$AWS_REGION" --name "$CLUSTER_NAME" [web:88]
# If your nodegroup name differs, update it here:
NODEGROUP_NAME="${CLUSTER_NAME/-eks/}-ng"
aws eks wait nodegroup-active --region "$AWS_REGION" --cluster-name "$CLUSTER_NAME" --nodegroup-name "$NODEGROUP_NAME" [web:81]

echo "3) kubeconfig"
aws eks update-kubeconfig --region "$AWS_REGION" --name "$CLUSTER_NAME"

echo "4) Build + push API image to ECR"
aws ecr get-login-password --region "$AWS_REGION" \
  | docker login --username AWS --password-stdin "$(echo "$API_REPO_URL" | cut -d/ -f1)"

docker build -t "${API_REPO_URL}:v1" apps/api
docker push "${API_REPO_URL}:v1"
export API_IMAGE="${API_REPO_URL}:v1"

echo "5) Render + apply manifests"
./scripts/render-k8s.sh
kubectl apply -f k8s/rendered/00-namespace.yaml
kubectl apply -f k8s/rendered/10-otel-collector.yaml
kubectl apply -f k8s/rendered/20-fluent-bit.yaml
kubectl apply -f k8s/rendered/30-api.yaml

echo "Done."
echo "Test:"
echo "  kubectl get pods -n observability"
echo "  kubectl -n default port-forward svc/observability-api 8080:80"  # namespace explicit [web:86][web:92]
echo "  curl -s http://127.0.0.1:8080/work"
