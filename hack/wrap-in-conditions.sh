#!/usr/bin/env bash
# Exit on error.
set -o errexit -o nounset -o pipefail

#
# Wraps templates in conditions.
#

# Get repository path.
repository="$(realpath "$(dirname "${0}")/..")"

# Define templates.
template_dir="${repository}/helm/cluster-api-provider-azure/templates"
templates=(
    "${template_dir}/v1_secret_credential-default.yaml"
    "${template_dir}/rbac.authorization.k8s.io_v1_role_capz-leader-election-role.yaml"
    "${template_dir}/rbac.authorization.k8s.io_v1_rolebinding_capz-leader-election-rolebinding.yaml"
    "${template_dir}/rbac.authorization.k8s.io_v1_clusterrole_capz-aad-pod-id-nmi-role.yaml"
    "${template_dir}/rbac.authorization.k8s.io_v1_clusterrolebinding_capz-aad-pod-id-nmi-binding.yaml"
)

# Iterate templates.
for template in "${templates[@]}"
do
    # Concatenate new template with conditions.
    echo '{{ if eq .Values.provider.flavor "capi" }}' > "${template}.new"
    cat "${template}" >> "${template}.new"
    echo '{{ end }}' >> "${template}.new"

    # Move new template to original.
    mv "${template}.new" "${template}"
done
