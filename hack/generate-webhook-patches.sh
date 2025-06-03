#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Generates webhook patches.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Define config path.
config="${repository}/config/helm"

# Generates a patch.
function generate_patch() {
  # Get components, kind, name & patch.
  local components="${1}"
  local kind="${2}"
  local name="${3}"
  local patch="${4}"

  # Remove existing patch.
  rm -f "${patch}"

  # Get webhooks.
  length="$(yq --exit-status 'select(.kind == "'"${kind}"'" and .metadata.name == "'"${name}"'") | .webhooks | length' "${components}")"

  # Iterate webhooks.
  for i in $(seq 0 $((${length} - 1)))
  do
    cat << EOF >> "${patch}"
- op: add
  path: /webhooks/${i}/objectSelector
  value: '{{- include "cluster-api-provider-azure.objectSelector" $ }}'
EOF
  done
}

# Generate patches.
generate_patch "${config}/bases/infrastructure-components.yaml" "MutatingWebhookConfiguration"   "capz-mutating-webhook-configuration"   "${config}/patches/mutatingwebhooks/capz-mutating-webhook-configuration-object-selector.yaml"
generate_patch "${config}/bases/infrastructure-components.yaml" "ValidatingWebhookConfiguration" "capz-validating-webhook-configuration" "${config}/patches/validatingwebhooks/capz-validating-webhook-configuration-object-selector.yaml"
