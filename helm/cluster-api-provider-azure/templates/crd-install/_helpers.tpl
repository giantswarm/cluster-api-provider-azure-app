{{/*
Create a default fully qualified app name.
*/}}
{{- define "cluster-api-provider-azure.crd-install.fullname" -}}
{{- printf "%s-%s" (include "cluster-api-provider-azure.fullname" .) "crd-install" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cluster-api-provider-azure.crd-install.selectorLabels" -}}
{{- include "cluster-api-provider-azure.selectorLabels" . }}
app.kubernetes.io/component: crd-install
{{- end }}

{{/*
Common annotations
*/}}
{{- define "cluster-api-provider-azure.crd-install.annotations" -}}
helm.sh/hook: pre-install,pre-upgrade
helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
{{- end }}
