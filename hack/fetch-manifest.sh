#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Fetches upstream Cluster API Provider Azure components for Kustomization.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Get Cluster API Provider Azure version.
version="$(yq --exit-status ".image.tag" "${repository}/helm/cluster-api-provider-azure/values.yaml")"

# Fetch Cluster API Provider Azure components.
curl --silent --show-error --fail --location \
    "https://github.com/giantswarm/cluster-api-provider-azure/releases/download/${version}/infrastructure-components.yaml" \
    --output "${repository}/config/helm/input/infrastructure-components.yaml"
