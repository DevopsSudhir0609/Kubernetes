{{- define "mychart" }}
labels:
  name: {{ .Values.name }}
replicas: {{ .Values.replicas }}

image: {{ .Values.image }}
port: {{ .Values.port }}

containerPort: {{ .Values.service.containerport }}
type: {{ .Values.servicetype }}
{{- end }}