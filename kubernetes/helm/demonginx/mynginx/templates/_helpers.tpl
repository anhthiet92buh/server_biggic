{{/*
Common labels 
*/}}
{{- define "common.labels" -}}
app: nginx
type: demo
identity_key: {{ .Values.indentity_key }}
{{- end }}
