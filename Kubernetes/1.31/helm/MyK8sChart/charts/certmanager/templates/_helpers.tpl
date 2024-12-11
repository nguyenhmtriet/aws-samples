{{- define "myk8schart.certificateSpec" }}
renewBefore: 240h
duration: 2160h
commonName: {{ .Values.commonName }}
dnsNames:
  {{- range .Values.dnsNames }}
  - {{ . }}
  {{- end }}
issuerRef:
  name: {{ .Release.Name }}-letsencrypt-issuer
  kind: Issuer

privateKey:
  algorithm: RSA
  encoding: PKCS1
  size: 2048

keystores:
  pkcs12:
    create: true
    passwordSecretRef:
      name: {{ .Release.Name }}-route53-creds-secret
      key: tls-password

isCA: false
usages:
  - digital signature
  - key encipherment
  - server auth

subject:
  organizations:
    - My Organization, LLC
{{- end }}