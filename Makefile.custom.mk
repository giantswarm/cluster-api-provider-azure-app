.PHONY: generate
generate:
	# Fetch Cluster API Provider Azure components.
	hack/fetch-manifest.sh

	# Generate webhook patches.
	hack/generate-webhook-patches.sh

	# Kustomize templates.
	rm -f helm/cluster-api-provider-azure/templates/*.yaml
	cp config/helm/copy/*.yaml helm/cluster-api-provider-azure/templates/
	kubectl kustomize config/helm --output helm/cluster-api-provider-azure/templates

	./hack/move-generated-crds.sh
	./hack/generate-crd-version-patches.sh
	./hack/cleanup-helm-templates.sh
	./hack/generate-helm-conditions.sh
