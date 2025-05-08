{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "crd-install.name" -}}
{{- printf "%s-%s" (include "name" .) "crd-install" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "crd-install.labels" -}}
app.kubernetes.io/name: {{ include "name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: crd-install
{{- end -}}

{{- define "crd-install.annotations" -}}
helm.sh/hook: pre-install,pre-upgrade
helm.sh/hook-delete-policy: before-hook-creation,hook-succeeded
{{- end -}}

{{/* CAPI Filtering templates */}}
{{/*
Watch filter value:
  CAPI MCs: empty (controllers are reconciling all CRs on CAPI MCs)
  Vintage MCs: capi (controllers are watching only labeled CRs and are not reconciling vintage WC CRs)
*/}}
{{/* Define objectSelector for webhooks */}}
{{- define "capz.webhookObjectSelector" -}}
{{- if eq .Values.provider.flavor "capi" -}}
{{- printf " %s" "{}" -}}
{{- else }}
    matchLabels:
      cluster.x-k8s.io/watch-filter: capi
{{- end -}}
{{- end -}}

{{- define "deployment.args.watchfiltervalue" -}}
{{- if eq .Values.provider.flavor "capi" -}}
{{- else -}}
capi
{{- end -}}
{{- end -}}
