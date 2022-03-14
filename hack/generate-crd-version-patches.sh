#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

ROOT_DIR="./$(dirname "$0")/.."
ROOT_DIR="$(realpath "$ROOT_DIR")"
KUSTOMIZE_CRD_DIR="$ROOT_DIR/helm/cluster-api-provider-azure/files"

# YQ="./$(dirname "$0")/tools/bin/yq"

# shellcheck disable=SC2066
for CRD_DIR in "$KUSTOMIZE_CRD_DIR/infrastructure"; do
    CRD_BASE_DIR="${CRD_DIR}/bases"
    CRD_VERSION_PATCHES_DIR="${CRD_DIR}/patches/versions"

    # remove old patches
    rm -rf "${CRD_VERSION_PATCHES_DIR:?}"/v*

    KUSTOMIZATION_FILE="${CRD_DIR}/kustomization.yaml"

    if [ ! -f "$KUSTOMIZATION_FILE" ]; then
        cat > "$KUSTOMIZATION_FILE" << EOF
resources:

patches:

EOF
    else
        # clean up resource list
        yq e -i '.resources = null' "$KUSTOMIZATION_FILE"

        # clean up API version patches
        for ((i=$(yq eval '.patches | length' "$KUSTOMIZATION_FILE")-1; i>=0; i--)); do
            patch_path=$(j="$i" yq e '.patches[env(j)].path' "$KUSTOMIZATION_FILE")

            if [[ "$patch_path" = patches/versions* ]]; then
                j="$i" yq e -i 'del .patches[env(j)]' "$KUSTOMIZATION_FILE"
            fi
        done

        patch_len=$(yq eval '.patches | length' "$KUSTOMIZATION_FILE")
        if [ "$patch_len" -eq "0" ]; then
            yq e -i '.patches = null' "$KUSTOMIZATION_FILE"
        fi
    fi

    for crd in "${CRD_BASE_DIR}"/*.yaml
    do
        crd_name="$(yq e '.metadata.name' "$crd")"
        echo "$crd_name"
        crd_filename="$(basename "$crd")"

        # Add CRD base to kustomization.yaml
        yq eval -i '.resources += ["bases/'"$crd_filename"'"]' "$KUSTOMIZATION_FILE"

        version_index=0
        for version in $(yq e '.spec.versions[].name' "$crd")
        do
            version_patches_dir="$CRD_VERSION_PATCHES_DIR/$version"
            mkdir -p "$version_patches_dir"

            patch_file="$version_patches_dir/$crd_filename"
            rm -f "$patch_file"

            echo "- op: replace
  path: /spec/versions/$version_index/schema
  value:
" > "$patch_file"

            version_obj="$(yq e ".spec.versions[$version_index].schema" "$crd")" \
                yq e -i '.[0].value = env(version_obj)' "$patch_file"

            # Add CRD version patches to kustomization.yaml
            version_patch_entry="path: patches/versions/$version/$crd_filename
target:
    group: apiextensions.k8s.io
    version: v1
    kind: CustomResourceDefinition
    name: $crd_name
" \
            yq eval -i '.patches += [env(version_patch_entry)]' "$KUSTOMIZATION_FILE"

            # Delete version data from the CRD base
            yq e -i ".spec.versions[$version_index].schema = {}" "$crd"
            version_index=$((version_index+1))
        done
    done
done
