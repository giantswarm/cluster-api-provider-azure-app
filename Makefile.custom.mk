.PHONY: generate
generate: ## Builds the manifests to publish with a release
	./hack/generate-kustomize-patches.sh
	@rm -rf helm/cluster-api-provider-azure/templates/*.yaml
	@cp helm/cluster-api-provider-azure/files/copy/* helm/cluster-api-provider-azure/templates/
	@kustomize build config/helm -o helm/cluster-api-provider-azure/templates
	./hack/move-generated-crds.sh
	./hack/generate-crd-version-patches.sh

.PHONY: verify
verify: generate
	@if !(git diff --quiet HEAD); then \
		git diff; \
		echo "generated files are out of date, run make generate"; exit 1; \
	fi
