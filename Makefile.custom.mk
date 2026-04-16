.PHONY: generate
generate:
	# Fetch Cluster API Provider Azure components.
	hack/fetch-manifest.sh

	# Kustomize templates.
	hack/kustomize-templates.sh

	# Move CRDs.
	hack/move-crds.sh

	# Generate CRD patches.
	hack/generate-crd-patches.sh
