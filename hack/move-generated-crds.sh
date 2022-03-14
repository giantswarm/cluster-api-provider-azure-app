#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# dirs
HELM_DIR="helm/cluster-api-provider-azure"
HELM_TEMPLATES_DIR="$HELM_DIR/templates"

move-infrastructure-manifests() {
    # move core plane CRDs to kustomize dir, because we are not deploying them with helm
    CRD_BASE_DIR="$HELM_DIR/files/infrastructure/bases"
    rm -f "./$CRD_BASE_DIR"/*
    mkdir -p "./$CRD_BASE_DIR"
    mv ${HELM_TEMPLATES_DIR}/apiextensions.k8s.io_v1_customresourcedefinition_*.infrastructure.cluster.x-k8s.io.yaml "./$CRD_BASE_DIR/"

    cd "$CRD_BASE_DIR"
    for crd_file in apiextensions.k8s.io_v1_customresourcedefinition_*.cluster.x-k8s.io.yaml; do
        new_crd_file="$(echo "$crd_file" | cut -c50-)" # remove first 50 chars
        mv "$crd_file" "$new_crd_file"
    done
    cd ../../../../..
}

move-infrastructure-manifests
