{{ -define "mychart.labels" -}}
  labels:
    name {{.value.app.name -}}
{{- .end -}}

{{-define "mychart.image"}}
 container:
 -name: {{.values.image}}
 {{- .end -}}

 {{-define "mychart.service"}}
   service:
   type:{{.values.service.type}}
    port: {{.values.service.port}}
    {{-end}}

  {{ -define "mychart.labels"}}
    labels:
    name:{{.values.name}}
    {{-end}}

{{ -define "mychart.name"}}
   image :{{.values.image}}
{{-end}}

 {{-define "mychart.service}}
  service:
   port: {{.value.port.service }}  
   {{-end}}
   