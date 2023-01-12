#!/usr/bin/env bash

# This script will generate kustomize patches for webhooks by first getting the
# MutatingWebhookConfiguration and ValidatingWebhookConfiguration, so it
# generates patches only or those webhooks that are specified in upstream.
#
# This way we don't have to specify webhook patches manually, since those
# change from time to time, as CRDs are added, modified and removed.

set -o errexit
set -o nounset
set -o pipefail

# Directories
ROOT_DIR="./$(dirname "$0")/.."
ROOT_DIR="$(realpath "$ROOT_DIR")"
KUSTOMIZE_DIR="$ROOT_DIR/config/helm"
HELM_DIR="$ROOT_DIR/helm/cluster-api-provider-azure"
KUSTOMIZE_INPUT_DIR="$ROOT_DIR/config/helm/input"

# Download upstream manifests
helm_values="$HELM_DIR/values.yaml"
org="kubernetes-sigs"
repo="cluster-api-provider-azure"
version="$(yq e '.image.tag' "$helm_values")"
release_asset_filename="infrastructure-components.yaml"
url="https://github.com/$org/$repo/releases/download/$version/$release_asset_filename"
mkdir -p "$KUSTOMIZE_INPUT_DIR"
curl -L "$url" -o "$KUSTOMIZE_INPUT_DIR/$release_asset_filename"

# Update kustomize patches for webhooks to add the `objectSelector` helm template 

# First clear previous watchfilter patches
true > "$KUSTOMIZE_DIR/mutating-webhook-watchfilter.yaml"
true > "$KUSTOMIZE_DIR/validating-webhook-watchfilter.yaml"

mutating_webhook_items=$(yq -e -N 'select(.kind=="MutatingWebhookConfiguration") | .webhooks | length' "$KUSTOMIZE_INPUT_DIR/$release_asset_filename")
for item in $(seq 0 $(($mutating_webhook_items-1))); do
  echo "- op: add" >> "$KUSTOMIZE_DIR/mutating-webhook-watchfilter.yaml"
  echo "  path: /webhooks/$item/objectSelector" >> "$KUSTOMIZE_DIR/mutating-webhook-watchfilter.yaml"
  echo "  value: '{{- include \"capz.webhookObjectSelector\" $ }}'" >> "$KUSTOMIZE_DIR/mutating-webhook-watchfilter.yaml"
done

validating_webhook_items=$(yq -e -N 'select(.kind=="ValidatingWebhookConfiguration") | .webhooks | length' "$KUSTOMIZE_INPUT_DIR/$release_asset_filename")
for item in $(seq 0 $(($validating_webhook_items-1))); do
  echo "- op: add" >> "$KUSTOMIZE_DIR/validating-webhook-watchfilter.yaml"
  echo "  path: /webhooks/$item/objectSelector" >> "$KUSTOMIZE_DIR/validating-webhook-watchfilter.yaml"
  echo "  value: '{{- include \"capz.webhookObjectSelector\" $ }}'" >> "$KUSTOMIZE_DIR/validating-webhook-watchfilter.yaml"
done
