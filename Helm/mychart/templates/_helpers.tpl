
{{-define "mychart" }}
 labels:
    name: {{.value.name }}
 replicas: {{.value.replicas }}

 image: {{ .values.image }}
 port: {{.values.port }}


 Port: {{ .values.service.containerport }}
 type:{{ .values.servicetype }}



 


   
