#!/usr/bin/env bash

# Directories
ROOT_DIR="./$(dirname "$0")/.."
ROOT_DIR="$(realpath "$ROOT_DIR")"
HELM_DIR="$ROOT_DIR/helm/cluster-api-provider-azure"

# This script prepends helm if statement to every Helm template, which checks
# if .Values.provider.flavor is equal to "capi".

capi_only_templates=()
capi_only_templates+=("${HELM_DIR}/templates/v1_secret_credential-default.yaml")
capi_only_templates+=("${HELM_DIR}/templates/rbac.authorization.k8s.io_v1_role_capz-leader-election-role.yaml")
capi_only_templates+=("${HELM_DIR}/templates/rbac.authorization.k8s.io_v1_rolebinding_capz-leader-election-rolebinding.yaml")
capi_only_templates+=("${HELM_DIR}/templates/rbac.authorization.k8s.io_v1_clusterrole_capz-aad-pod-id-nmi-role.yaml")
capi_only_templates+=("${HELM_DIR}/templates/rbac.authorization.k8s.io_v1_clusterrolebinding_capz-aad-pod-id-nmi-binding.yaml")

for template_file in "${capi_only_templates[@]}"; do
    if [ "$(uname)" = Darwin ]; then
        # shellcheck disable=SC1003
        sed -i '' '1i\'$'\n''{{ if eq .Values.provider.flavor "capi" }}'$'\n''' "$template_file"
    else
        sed -i '' '1i {{ if eq .Values.provider.flavor "capi" }}' "$template_file"
    fi
    echo '{{ end }}' >> "$template_file"
done
