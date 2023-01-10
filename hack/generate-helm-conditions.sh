
#!/usr/bin/env bash

# Directories
ROOT_DIR="./$(dirname "$0")/.."
ROOT_DIR="$(realpath "$ROOT_DIR")"
HELM_DIR="$ROOT_DIR/helm/cluster-api-provider-azure"

# This script prepends helm if statement to every Helm template, which checks
# if .Values.provider.flavor is equal to "capi".

capi_only_templates=()
capi_only_templates+=("${HELM_DIR}/templates/v1_secret_credential-default.yaml")

for template_file in ${capi_only_templates[@]}; do
    sed -i '1i {{ if eq .Values.provider.flavor "capi" }}' "$template_file"
    echo '{{ end }}' >> "$template_file"
done
