{{/*
Create a default fully qualified app name.
*/}}
{{- define "cluster-api-provider-azure.crd-install.fullname" -}}
{{- printf "%s-%s" (include "cluster-api-provider-azure.fullname" .) "crd-install" | trunc 63 | trimSuffix "-" }}
{{- end }}
