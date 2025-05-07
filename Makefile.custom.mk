.PHONY: generate
generate:
	# Fetch Cluster API Provider Azure components.
	hack/fetch-manifest.sh

	# Generate webhook patches.
	hack/generate-webhook-patches.sh

	# Kustomize templates.
	rm -f helm/cluster-api-provider-azure/templates/*.yaml
	kubectl kustomize config/helm --output helm/cluster-api-provider-azure/templates

	# Move CRDs.
	hack/move-crds.sh

	# Generate CRD patches.
	hack/generate-crd-patches.sh

	# Wrap templates in conditions.
	hack/wrap-in-conditions.sh

	./hack/cleanup-helm-templates.sh
