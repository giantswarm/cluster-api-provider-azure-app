.PHONY: generate
generate:
	./hack/generate-kustomize-patches.sh
	@rm -rf helm/cluster-api-provider-azure/templates/*.yaml
	@cp helm/cluster-api-provider-azure/files/copy/* helm/cluster-api-provider-azure/templates/
	@kustomize build config/helm -o helm/cluster-api-provider-azure/templates
	./hack/move-generated-crds.sh
	./hack/generate-crd-version-patches.sh
	./hack/cleanup-helm-templates.sh
	./hack/generate-helm-helpers.sh
	./hack/generate-helm-conditions.sh

.PHONY: verify
verify: generate
	@if !(git diff --quiet HEAD); then \
		git diff; \
		echo "generated files are out of date, run make generate"; exit 1; \
	fi
