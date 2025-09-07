#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Moves CRDs from the chart's templates to infrastructure bases.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Remove existing CRDs.
rm -f "${repository}/helm/cluster-api-provider-azure/charts/crd-install/files/infrastructure/bases/"*".yaml"

# Iterate generated CRDs.
for crd_path in "${repository}/helm/cluster-api-provider-azure/templates/apiextensions.k8s.io_v1_customresourcedefinition_"*".yaml"
do
    # Get & shorten CRD file name.
    crd_file="$(basename "${crd_path}")"
    crd_file="${crd_file#apiextensions.k8s.io_v1_customresourcedefinition_}"

    # Move generated CRD.
    mv "${crd_path}" "${repository}/helm/cluster-api-provider-azure/charts/crd-install/files/infrastructure/bases/${crd_file}"
done
