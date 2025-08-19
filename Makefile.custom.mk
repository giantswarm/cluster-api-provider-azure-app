.PHONY: generate
generate:
	# Fetch Cluster API Provider Azure components.
	hack/fetch-manifest.sh

	# Kustomize templates.
	rm -f helm/cluster-api-provider-azure/templates/*.yaml
	kubectl kustomize config/helm --output helm/cluster-api-provider-azure/templates

	# Move CRDs.
	hack/move-crds.sh

	# Generate CRD patches.
	hack/generate-crd-patches.sh
