{{/*
Expand the name of the chart.
*/}}
{{- define "cluster-api-provider-azure.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "cluster-api-provider-azure.fullname" -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
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
{{- define "cluster-api-provider-azure.labels" -}}
helm.sh/chart: {{ include "cluster-api-provider-azure.chart" . }}
{{ include "cluster-api-provider-azure.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
application.giantswarm.io/team: {{ index .Chart.Annotations "application.giantswarm.io/team" | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cluster-api-provider-azure.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cluster-api-provider-azure.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Watch filter templates

On CAPI MCs, the controllers reconcile all CRs.
On Vintage MCs, the controllers reconcile labeled CRs only.
*/}}

{{/*
Webhook object selector
*/}}
{{- define "cluster-api-provider-azure.objectSelector" -}}
{{- if eq .Values.provider.flavor "capi" }}
{{- printf " %s" "{}" }}
{{- else }}
    matchLabels:
      cluster.x-k8s.io/watch-filter: capi
{{- end }}
{{- end }}

{{/*
Controller watch filter
*/}}
{{- define "cluster-api-provider-azure.watchFilter" -}}
{{- if eq .Values.provider.flavor "capi" }}
{{- else -}}
capi
{{- end }}
{{- end }}
