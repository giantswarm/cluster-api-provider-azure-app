#!/usr/bin/env bash

# This script prepends helm if statement to every Helm template, which checks
# if .Values.provider.flavor is equal to "capi".

# Directories
ROOT_DIR="./$(dirname "$0")/.."
ROOT_DIR="$(realpath "$ROOT_DIR")"
HELM_DIR="$ROOT_DIR/helm/cluster-api-provider-azure"

for template_file in "$HELM_DIR"/templates/admissionregistration.k8s.io_v1_*webhookconfiguration_*.yaml; do
    temp_template_file="$template_file.tmp"
    echo '{{ if eq .Values.provider.flavor "capi" }}' | cat - "$template_file" > "$temp_template_file" && mv "$temp_template_file" "$template_file"
    echo '{{ end }}' >> "$template_file"
done
