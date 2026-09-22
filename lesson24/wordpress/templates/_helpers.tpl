{{- define "wordpress.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "wordpress.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name (include "wordpress.name" .) | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "wordpress.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "wordpress.labels" -}}
helm.sh/chart: {{ include "wordpress.chart" . }}
app.kubernetes.io/name: {{ include "wordpress.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{- define "wordpress.mysqlLabels" -}}
{{ include "wordpress.labels" . }}
app.kubernetes.io/component: mysql
{{- end -}}

{{- define "wordpress.wordpressLabels" -}}
{{ include "wordpress.labels" . }}
app.kubernetes.io/component: wordpress
{{- end -}}

{{- define "wordpress.mysqlSelectorLabels" -}}
app.kubernetes.io/name: {{ include "wordpress.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: mysql
{{- end -}}

{{- define "wordpress.wordpressSelectorLabels" -}}
app.kubernetes.io/name: {{ include "wordpress.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: wordpress
{{- end -}}

{{- define "wordpress.storageClassName" -}}
{{- if .Values.storageClass.name -}}
{{- .Values.storageClass.name -}}
{{- else -}}
{{- printf "%s-local" (include "wordpress.fullname" .) -}}
{{- end -}}
{{- end -}}

{{- define "wordpress.mysqlServiceName" -}}
{{- printf "%s-mysql" (include "wordpress.fullname" .) -}}
{{- end -}}

{{- define "wordpress.wordpressServiceName" -}}
{{- printf "%s-wordpress" (include "wordpress.fullname" .) -}}
{{- end -}}

{{- define "wordpress.mysqlSecretName" -}}
{{- printf "%s-mysql-secret" (include "wordpress.fullname" .) -}}
{{- end -}}

{{- define "wordpress.wordpressSecretName" -}}
{{- printf "%s-wordpress-secret" (include "wordpress.fullname" .) -}}
{{- end -}}

{{- define "wordpress.mysqlConfigName" -}}
{{- printf "%s-mysql-config" (include "wordpress.fullname" .) -}}
{{- end -}}

{{- define "wordpress.wordpressConfigName" -}}
{{- printf "%s-wordpress-config" (include "wordpress.fullname" .) -}}
{{- end -}}
