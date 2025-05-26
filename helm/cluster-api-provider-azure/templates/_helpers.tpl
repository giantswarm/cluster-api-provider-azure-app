{{/*
Expand the name of the chart.
*/}}
{{- define "cluster-api-provider-azure.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "cluster-api-provider-azure.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "labels.common" -}}
{{ include "labels.selector" . }}
application.giantswarm.io/branch: {{ .Values.project.branch | quote }}
application.giantswarm.io/commit: {{ .Values.project.commit | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
helm.sh/chart: {{ include "cluster-api-provider-azure.chart" . | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "application.giantswarm.io/team" | quote }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "labels.selector" -}}
{{ include "labels.provider" . }}
app.kubernetes.io/name: {{ include "cluster-api-provider-azure.name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Provider labels
*/}}
{{- define "labels.provider" -}}
cluster.x-k8s.io/provider: infrastructure-azure
{{- end -}}

{{- define "capz.crdInstall" -}}
{{- printf "%s-%s" ( include "cluster-api-provider-azure.name" . ) "crd-install" | replace "+" "_" | trimSuffix "-" -}}
{{- end -}}

{{- define "capz.CRDInstallAnnotations" -}}
"helm.sh/hook": "pre-install,pre-upgrade"
"helm.sh/hook-delete-policy": "before-hook-creation,hook-succeeded"
{{- end -}}

{{- define "capz.CRDInstallConfigmapNameGenerate" -}}
{{- $cmName := printf "%s-%s" (base (dir .)) (trimSuffix ".yaml" (base .) | trunc 63) -}}
{{- $cmName = $cmName | trimSuffix "." -}}
{{- $cmName -}}
{{- end -}}

{{- define "capz.selectorLabels" -}}
app.kubernetes.io/name: "{{ template "cluster-api-provider-azure.name" . }}"
app.kubernetes.io/instance: "{{ template "cluster-api-provider-azure.name" . }}"
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
