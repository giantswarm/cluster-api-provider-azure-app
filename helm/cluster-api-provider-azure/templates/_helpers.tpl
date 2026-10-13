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
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimAll "-._" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cluster-api-provider-azure.labels" -}}
helm.sh/chart: {{ include "cluster-api-provider-azure.chart" . }}
{{ include "cluster-api-provider-azure.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
application.giantswarm.io/team: {{ index .Chart.Annotations "io.giantswarm.application.team" | quote }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "cluster-api-provider-azure.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cluster-api-provider-azure.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
ASO CRDs that Giant Swarm requires on every installation,
on top of the upstream CAPZ defaults in --crd-pattern.
*/}}
{{- define "cluster-api-provider-azure.aso.internalCRDs" -}}
- eventhub.azure.com/Namespace
- eventhub.azure.com/NamespacesEventhub
- eventhub.azure.com/NamespacesAuthorizationRule
- eventhub.azure.com/NamespacesEventhubsConsumerGroup
- insights.azure.com/DiagnosticSetting
{{- end }}

{{/*
Value of ADDITIONAL_ASO_CRDS: internal CRDs plus customer-provided aso.additionalCRDs.
The internal list is never empty, so the result never yields an empty pattern segment,
which would make ASO fail to start.
*/}}
{{- define "cluster-api-provider-azure.aso.additionalCRDs" -}}
{{- $internal := include "cluster-api-provider-azure.aso.internalCRDs" . | fromYamlArray }}
{{- concat $internal .Values.aso.additionalCRDs | uniq | join ";" }}
{{- end }}
