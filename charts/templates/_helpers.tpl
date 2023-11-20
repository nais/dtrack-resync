{{/*
Expand the name of the chart.
*/}}
{{- define "dtrack-job.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}


{{- define "dtrack-job-backend.name" -}}
{{- .Chart.Name }}-backend
{{- end }}

{{- define "dtrack-job-frontend.name" -}}
{{- .Chart.Name }}-frontend
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this ().
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dtrack-job.fullname" -}}
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
{{- define "dtrack-job.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dtrack-job-backend.labels" -}}
helm.sh/chart: {{ include "dtrack-job.chart" . }}
{{ include "dtrack-job-backend.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dtrack-job-frontend.labels" -}}
helm.sh/chart: {{ include "dtrack-job.chart" . }}
{{ include "dtrack-job-frontend.selectorLabels" . }}
{{- if .Chart.Version }}
app.kubernetes.io/version: {{ .Chart.Version | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels for backend
*/}}
{{- define "dtrack-job-backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dtrack-job.name" . }}
app.kubernetes.io/instance: {{ include "dtrack-job-backend.name" . }}
{{- end }}

{{/*
Selector labels for frontend
*/}}
{{- define "dtrack-job-frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dtrack-job.name" . }}
app.kubernetes.io/instance: {{ include "dtrack-job-frontend.name" . }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "dtrack-job.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "dtrack-job.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
