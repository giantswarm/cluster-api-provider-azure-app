.PHONY: generate
generate:
	@rm -rf helm/cluster-api-provider-azure/templates/*.yaml
	@kustomize build config/helm -o helm/cluster-api-provider-azure/templates
	@rm -rf helm/cluster-api-provider-azure/templates/apiextensions*.yaml helm/cluster-api-provider-azure/templates/v1_secret_capz-manager-bootstrap-credentials.yaml

.PHONY: verify
verify: generate
	@if !(git diff --quiet HEAD); then \
		git diff; \
		echo "generated files are out of date, run make generate"; exit 1; \
	fi
