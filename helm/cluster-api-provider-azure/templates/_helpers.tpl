{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "labels.common" -}}
{{ include "labels.selector" . }}
application.giantswarm.io/branch: {{ .Values.project.branch | quote }}
application.giantswarm.io/commit: {{ .Values.project.commit | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "labels.selector" -}}
{{ include "labels.provider" . }}
app.kubernetes.io/name: {{ include "name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Provider labels
*/}}
{{- define "labels.provider" -}}
cluster.x-k8s.io/provider: infrastructure-azure
{{- end -}}

{{- define "capz.crdInstall" -}}
{{- printf "%s-%s" ( include "name" . ) "crd-install" | replace "+" "_" | trimSuffix "-" -}}
{{- end -}}

{{- define "capz.CRDInstallAnnotations" -}}
"helm.sh/hook": "pre-install,pre-upgrade"
"helm.sh/hook-delete-policy": "before-hook-creation,hook-succeeded"
{{- end -}}

{{- define "capz.selectorLabels" -}}
app.kubernetes.io/name: "{{ template "name" . }}"
app.kubernetes.io/instance: "{{ template "name" . }}"
{{- end -}}

{{/* Create a label which can be used to select any orphaned crd-install hook resources */}}
{{- define "capz.CRDInstallSelector" -}}
{{- printf "%s" "crd-install-hook" -}}
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
