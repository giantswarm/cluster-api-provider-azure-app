#!/usr/bin/env bash

# Directories
ROOT_DIR="./$(dirname "$0")/.."
ROOT_DIR="$(realpath "$ROOT_DIR")"
HELM_DIR="$ROOT_DIR/helm/cluster-api-provider-azure"

# This script does some final cleanup to the helm templates

# Remove `objectSelector ...` single quotes
for template_file in "$HELM_DIR"/templates/admissionregistration.k8s.io_v1_*webhookconfiguration_*.yaml; do
    sed -i "s/\(.*\)objectSelector: '\(.*\)'/\1objectSelector: \2/" "$template_file"
done
