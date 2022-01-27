.PHONY: generate
generate:
	kustomize build config/helm -o helm/cluster-api-provider-azure/templates
	rm -rf helm/cluster-api-provider-azure/templates/apiextensions* helm/cluster-api-provider-azure/templates/apps_v1_daemonset* helm/cluster-api-provider-azure/templates/cert-manager.io_v1_issuer* helm/cluster-api-provider-azure/templates/*aad-pod-id-nmi* helm/cluster-api-provider-azure/templates/v1_secret_capz-manager-bootstrap-credentials.yaml
