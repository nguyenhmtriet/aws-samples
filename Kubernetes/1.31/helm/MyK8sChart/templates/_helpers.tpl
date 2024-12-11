{{/*
Create annotations of ingress nginx
*/}}
{{- define "myk8schart.ingress" }}
{{- range $key, $val := .Values.global.ingress.annotations }}
{{ $key }}: {{ $val | quote }}
{{- end }}
{{- end }}


{{/*
Create imagePullSecrets
*/}}
{{- define "myk8schart.imagePullSecrets" }}
{{- if .Values.global.imagePullSecrets }}
imagePullSecrets:
- name: {{ printf "%s-%s" .Release.Name .Values.global.imagePullSecrets }}
{{- end }}
{{- end }}


{{/*
Create Node Selector annotations
*/}}
{{- define "myk8schart.nodeSelector" }}
{{- if and (hasKey .Values.global "nodeSelector") (hasKey .Values.global.nodeSelector "kubernetes.io/os") }}
nodeSelector:
{{- range $key, $val := .Values.global.nodeSelector }}
  {{- $key | nindent 2 }}: {{ $val }} 
{{- end }}
{{- end }}
{{- end }}