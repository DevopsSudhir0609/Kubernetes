
{{- define "mychart" }}
 labels:
    name: {{ .values.name }}
 replicas: {{ .values.replicas }}

 image: {{ .values.image }}
 port: {{ .values.port }}


 Port: {{ .values.service.containerport }}
 type: {{ .values.servicetype }}



 


   
