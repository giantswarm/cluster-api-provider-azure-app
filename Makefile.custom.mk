.PHONY: generate
generate:
	./hack/generate-kustomize-patches.sh
	@rm -rf helm/cluster-api-provider-azure/templates/*.yaml
	@cp config/helm/copy/* helm/cluster-api-provider-azure/templates/
	@kubectl kustomize config/helm --output helm/cluster-api-provider-azure/templates
	./hack/move-generated-crds.sh
	./hack/generate-crd-version-patches.sh
	./hack/cleanup-helm-templates.sh
	./hack/generate-helm-conditions.sh
