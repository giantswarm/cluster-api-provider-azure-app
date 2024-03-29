{{/* vim: set filetype=mustache: */}}
{{/*
Create a name stem for resource names
When pods for deployments are created they have an additional 16 character
suffix appended, e.g. "-957c9d6ff-pkzgw". Given that Kubernetes allows 63
characters for resource names, the stem is truncated to 47 characters to leave
room for such suffix.
*/}}
{{- define "resource.default.name" -}}
cluster-api-provider-azure
{{- end -}}

{{- define "resource.networkPolicy.name" -}}
{{- include "resource.default.name" . -}}-network-policy
{{- end -}}

{{- define "resource.psp.name" -}}
{{- include "resource.default.name" . -}}-psp
{{- end -}}

{{- define "resource.pullSecret.name" -}}
{{- include "resource.default.name" . -}}-pull-secret
{{- end -}}

{{- define "resource.default.namespace" -}}
giantswarm
{{- end -}}

{{- define "resource.app.version" -}}
0.0.0
{{- end -}}
