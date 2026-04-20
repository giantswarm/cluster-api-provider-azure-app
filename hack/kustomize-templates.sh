#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

version=$(kubectl version --client --output json)
echo "using kubectl version $(echo $version | jq -r .clientVersion.gitVersion)"
echo "using bundled kustomize version $(echo $version | jq -r .kustomizeVersion)"

rm -f helm/cluster-api-provider-azure/templates/*.yaml
kubectl kustomize config/helm --output helm/cluster-api-provider-azure/templates
