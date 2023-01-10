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
capi_only_templates+=("${HELM_DIR}/templates/apps_v1_daemonset_capz-nmi.yaml")
capi_only_templates+=("${HELM_DIR}/templates/rbac.authorization.k8s.io_v1_clusterrole_capz-aad-pod-id-nmi-role.yaml")
capi_only_templates+=("${HELM_DIR}/templates/rbac.authorization.k8s.io_v1_clusterrolebinding_capz-aad-pod-id-nmi-binding.yaml")
capi_only_templates+=("${HELM_DIR}/templates/apiextensions.k8s.io_v1_customresourcedefinition_azureidentities.aadpodidentity.k8s.io.yaml")
capi_only_templates+=("${HELM_DIR}/templates/apiextensions.k8s.io_v1_customresourcedefinition_azureidentitybindings.aadpodidentity.k8s.io.yaml")
capi_only_templates+=("${HELM_DIR}/templates/apiextensions.k8s.io_v1_customresourcedefinition_azurepodidentityexceptions.aadpodidentity.k8s.io.yaml")

for template_file in "${capi_only_templates[@]}"; do
    sed -i '1i {{ if eq .Values.provider.flavor "capi" }}' "$template_file"
    echo '{{ end }}' >> "$template_file"
done
