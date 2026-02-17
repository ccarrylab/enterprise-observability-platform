#!/usr/bin/env bash
set -euo pipefail

AWS_REGION="$(terraform -chdir=infra output -raw cluster_region)"
CLUSTER_NAME="$(terraform -chdir=infra output -raw cluster_name)"
OTEL_ROLE_ARN="$(terraform -chdir=infra output -raw otel_irsa_role_arn)"
FLUENTBIT_ROLE_ARN="$(terraform -chdir=infra output -raw fluentbit_irsa_role_arn)"
API_IMAGE="${API_IMAGE:-}"

if [[ -z "${API_IMAGE}" ]]; then
  echo "API_IMAGE is required (e.g., export API_IMAGE=123.dkr.ecr.../repo:tag)" >&2
  exit 1
fi

export AWS_REGION CLUSTER_NAME OTEL_ROLE_ARN FLUENTBIT_ROLE_ARN API_IMAGE

rm -rf k8s/rendered
mkdir -p k8s/rendered

cp k8s/templates/00-namespace.yaml k8s/rendered/

envsubst < k8s/templates/10-otel-collector.yaml.tpl > k8s/rendered/10-otel-collector.yaml
envsubst < k8s/templates/20-fluent-bit.yaml.tpl    > k8s/rendered/20-fluent-bit.yaml
envsubst < k8s/templates/30-api.yaml.tpl           > k8s/rendered/30-api.yaml

echo "Rendered manifests in k8s/rendered/"
