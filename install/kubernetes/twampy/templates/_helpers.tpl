{{/*
Expand the name of the chart.
*/}}
{{- define "twampy.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "twampy.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "twampy.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels for sender
*/}}
{{- define "twampy.sender.labels" -}}
helm.sh/chart: {{ include "twampy.chart" . }}
{{ include "twampy.sender.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels for responder
*/}}
{{- define "twampy.responder.labels" -}}
helm.sh/chart: {{ include "twampy.chart" . }}
{{ include "twampy.responder.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for sender
*/}}
{{- define "twampy.sender.selectorLabels" -}}
app.kubernetes.io/name: {{ include "twampy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: sender
{{- end }}

{{/*
Selector labels for responder
*/}}
{{- define "twampy.responder.selectorLabels" -}}
app.kubernetes.io/name: {{ include "twampy.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: responder
{{- end }}

{{/*
Create the name of the service account to use for the sender
*/}}
{{- define "twampy.sender.serviceAccountName" -}}
{{- if .Values.sender.serviceAccount.create }}
{{- default (include "twampy.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.sender.serviceAccount.name }}-sender
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use for the responder
*/}}
{{- define "twampy.responder-serviceAccountName" -}}
{{- if .Values.responder.serviceAccount.create }}
{{- default (include "twampy.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.sender.serviceAccount.name }}-responder
{{- end }}
{{- end }}
