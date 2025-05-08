#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Removes quotes breaking Helm templates from webhooks.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Iterate webhooks.
for webhook in "${repository}/helm/cluster-api-provider-azure/templates/admissionregistration.k8s.io_v1_"*"webhookconfiguration_"*".yaml"
do
    # Remove quotes.
    sed -i.bak "s/\(.*\)objectSelector: '\(.*\)'/\1objectSelector: \2/" "${webhook}"
    rm "${webhook}.bak"
done
