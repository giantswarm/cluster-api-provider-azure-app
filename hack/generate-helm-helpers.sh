#!/usr/bin/env bash

# This script will generate helm named templates with some changeable common
# values that are used across manifests, e.g. annotations and similar. Having
# these values in named templates makes pull request reviews easier, as less
# files are changed.

set -o errexit
set -o nounset
set -o pipefail

# Directories
ROOT_DIR="./$(dirname "$0")/.."
ROOT_DIR="$(realpath "$ROOT_DIR")"
HELM_DIR="$ROOT_DIR/helm/cluster-api-provider-azure"
HELPERS_GEN_PATH="$HELM_DIR/templates/_helpers_gen.tpl"
KUSTOMIZE_INPUT_DIR="$ROOT_DIR/config/helm/input"

# Download upstream manifests
helm_values="$HELM_DIR/values.yaml"
org="kubernetes-sigs"
repo="cluster-api-provider-azure"
version="$(yq e '.image.tag' "$helm_values")"
release_asset_filename="infrastructure-components.yaml"
url="https://github.com/$org/$repo/releases/download/$version/$release_asset_filename"
mkdir -p "$KUSTOMIZE_INPUT_DIR"
# curl -L "$url" -o "$KUSTOMIZE_INPUT_DIR/$release_asset_filename"

# Update kustomize patches for webhooks. We do this for every CRD

# First clear previously generated templates
true > "$HELPERS_GEN_PATH"

# kubebuilder version that we want to store in a named template
kubebuilder_version=""

# First get all CRDs that we need
wanted_crd_names=()
for crd_file in "$HELM_DIR"/files/*/bases/*.cluster.x-k8s.io.yaml; do
    crd_name="$(yq e 'select(.kind=="CustomResourceDefinition") | .metadata.name' "$crd_file")"
    wanted_crd_names+=("$crd_name")
done

for crd_name in $(yq e -N 'select(.kind=="CustomResourceDefinition") | .metadata.name' "$KUSTOMIZE_INPUT_DIR/$release_asset_filename"); do
    crd="$(
            crd_name="$crd_name" \
            yq e 'select((.kind=="CustomResourceDefinition") and .metadata.name==env(crd_name))' \
                "$KUSTOMIZE_INPUT_DIR/$release_asset_filename")"

    crd_name="$(echo "$crd" | yq e ".metadata.name")"

    # Check if the CRD is wanted or skipped
    crd_wanted=0
    for wanted_crd_name in "${wanted_crd_names[@]}"; do
        if [[ "$wanted_crd_name" == "$crd_name" ]]; then
            crd_wanted=1
            break
        fi
    done

    if [[ $crd_wanted -eq 0 ]]; then
        echo "Skipping kubebuilder annotation check for CRD $crd_name"
        continue
    fi

    crd_kubebuilder_version="$(echo "$crd" | yq e ".metadata.annotations[\"controller-gen.kubebuilder.io/version\"]")"

    if [[ -z $kubebuilder_version ]]; then
        kubebuilder_version="$crd_kubebuilder_version"
        echo "Using kubebuilder annotation value $crd_kubebuilder_version"
        continue
    fi

    if [[ "$kubebuilder_version" == "$crd_kubebuilder_version" ]]; then
        # all good, this CRD has the same kubebuilder version as the previous
        # one (all must be the same)
        continue
    fi

    echo "CRD $crd_name has kubebuilder version $crd_kubebuilder_version, which is different than $kubebuilder_version that is found in other CRDs. Please update kubebuilder version manually in $HELPERS_GEN_PATH." 1>&2
    exit 1
done

echo "Writing kubebuilder version to '$HELPERS_GEN_PATH'"

echo "{{/*
This file contains generated annotation values. All changes will be overwritten with 'make generate' command.
*/}}

{{- define \"annotations.kubebuilder_version\" -}}
$kubebuilder_version
{{- end -}}" > "$HELPERS_GEN_PATH"
