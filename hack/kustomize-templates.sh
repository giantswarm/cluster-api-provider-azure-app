#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

version=$(kubectl version --client --output json)
echo "using kubectl version $(echo $version | jq -r .clientVersion.gitVersion)"
echo "using bundled kustomize version $(echo $version | jq -r .kustomizeVersion)"

rm -f helm/cluster-api-provider-azure/templates/*.yaml

# Replace `clusterctl` variable expansion "${ADDITIONAL_ASO_CRDS}" with "$(ADDITIONAL_ASO_CRDS)",
# which works at runtime for reading a container env var.
sed -i -E 's|\$\{ADDITIONAL_ASO_CRDS(:[=-][^}]*)?\}|$(ADDITIONAL_ASO_CRDS)|g' config/helm/bases/infrastructure-components.yaml

kubectl kustomize config/helm --output helm/cluster-api-provider-azure/templates
